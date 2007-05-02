Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 654EDDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 02:30:01 +1000 (EST)
Message-ID: <4638BDB3.5070309@ru.mvista.com>
Date: Wed, 02 May 2007 20:34:59 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Xilinx framebuffer device driver - 2nd version
References: <4630F018.3010200@ru.mvista.com>
	<528646bc0704300201h55a9aa0aw84c24c0c9dfa6600@mail.gmail.com>
In-Reply-To: <528646bc0704300201h55a9aa0aw84c24c0c9dfa6600@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: rick.moleres@xilinx.com, arnd@arndb.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 4/26/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
>> Add support for the video controller IP block included into Xilinx 
>> ML300 and
>> ML403 reference designs.
>>
>> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
>> ---
>>
>> This patch relies on the "Patchset to establish sanity in Xilinx 
>> Virtex support" by Gran Likely to have
>> the frame buffer device registered on the platform bus. Without this 
>> patchset one needs to fill in
>> the struct platform_device and make sure platform_device_register() is 
>> called elsewhere.
>> The DCR access has been added but not tested - my targets are 
>> configured in the "memory mapped IO" way.
>> I would appreciate if those having the video controller registers 
>> accessible as DCRs
>> test the DCR mode.
>>
>> This is the 2nd version that addresses what was pointed out by Arnd 
>> and Grant.
>> Please find the interdiff against the 1st version below, and the whole 
>> patch attached to this message
>> Comments are welcome.
> 
> First off; I'm an idiot.  The ml403 ref design *does* use the opb2dcr
> bridge; and my design *does not* use DCR instructions; so I haven't
> been able to test direct DCR access.  :-)  It might just be better to
> drop the DCR stuff for now until it's accepted into mainline; or
> someone is able to test it.

I am inclined to leave the xilinx_fb_out_be32(driverdata, offset, val)
macro in the form of:

/*
  * The LCD controller has DCR interface to its registers, but all
  * the boards and configurations the driver has been tested with
  * use opb2dcr bridge. So the registers are seen as memory mapped.
  * This macro is to make it simple to add the direct DCR access
  * when it's needed.
  */
#define xilinx_fb_out_be32(driverdata, offset, val) \
	out_be32(driverdata->regs + offset, val)

> I've got it running on my custom board.   Seems to work well and it's
> more featureful than my driver, so I'll migrate over to using yours.
> The design that I'm using has a different color map from the ml300 ref
> design.  blue is at offset 0 and red offset 16 (vs. blue-16 and red-0
> on the ml300 ref design).   It's probably worthwhile to add those
> parameters to the xilinxfb_platform_data structure.

I've tested the driver with both ML300 and ML403 reference designs,
and *both* have blue at offset 0 and red at offset 16.
The "PLB TFT LCD Controller" documentation I have doesn't notice
any possibility to make the color map different from that.

>> Would be nice to get this driver into mainline for the 2.6.22.
> 
> I certainly support getting it submitted.  Have you emailed it to the
> linux-fb-devel list?

Not yet.
Not until we settle down on registers access, color map and other
hardware related stuff.

> Can you split the driver and the platform device registration up into
> 2 patches?

Good idea. Will do.

> It will probably make submission less painful; the device
> registration patch can go through paulus, and the driver itself
> through the linux-fbdev-devel list.
> 
>> ===================================================================
>> --- linux-2.6.20.orig/drivers/video/Kconfig
>> +++ linux-2.6.20/drivers/video/Kconfig
>> @@ -1648,6 +1648,16 @@ config FB_XILINX_ROTATE
>>         bool "Rotate display"
>>         depends on FB_XILINX
>>
>> +config FB_XILINX_SCR_HEIGHT
>> +       int "Screen height in mm"
>> +       depends on FB_XILINX
>> +       default 99
>> +
>> +config FB_XILINX_SCR_WIDTH
>> +       int "Screen width in mm"
>> +       depends on FB_XILINX
>> +       default 132
>> +
> 
> I'm not so fond of doing this via KCONFIG options; at least not at the
> driver level.  Also, the board I'm using will have 2 of these cores,
> each with different display dimesions.  For these parameters, I think
> it makes more sense for the board setup code to override
> virtex_device_fixup() and insert the correct values into the pdata
> structure before virtex_init() registers the device.  Individual board
> ports can add Kconfig setting for the dimensions if appropriate for
> the system.

Will remove these KCONFIG options and add virtex_device_fixup()
to arch/ppc/platforms/4xx/xilinx_ml300.c and arch/ppc/platforms/4xx/xilinx_ml403.c
in the new version of the xilinxfb patch (the platform device registration
part).

Thanks,
Andrei

> Cheers,
> g.
> 
