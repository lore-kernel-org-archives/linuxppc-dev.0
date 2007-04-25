Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id EDBEBDDF70
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 23:02:12 +1000 (EST)
Message-ID: <462F5272.7050308@ru.mvista.com>
Date: Wed, 25 Apr 2007 17:06:58 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Xilinx framebuffer device driver
References: <462E0D5C.1090105@ru.mvista.com>
	<528646bc0704241517g595bf7bfqe54e40b05f74e933@mail.gmail.com>
In-Reply-To: <528646bc0704241517g595bf7bfqe54e40b05f74e933@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Rick Moleres <rick.moleres@xilinx.com>, linuxppc-embedded@ozlabs.org
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
> On 4/24/07, Andrei Konovalov <akonovalov@ru.mvista.com> wrote:
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
>>
>> Reviews and comments are welcome.
>>
>> Would be nice to get this driver into mainline for the 2.6.22.
> 
> Quick comment on first perusal:  The driver uses the out_be32 macro
> directly for accessing registers, which doesn't work if the FB block
> is configured for DCR access (like the ML403 reference design).

Yes, that's true.
But (at least) the EDK 8.1 reference design for ML403 has also opb2dcr bridge.
That's why I've tested the patch without problems on ML403 (in addition
to ML300).

I'll add DCR access, but not sure if I need a separate bitstream to
test DCR access (could I access the DCR registers directly in presence
of the bridge or not).

> There will need to be a property in the platform device binding to determine
> how to access registers.

OK.
The only problem is that there is no indication in the xparameters.h of how the
registers should be accessed (via DCR or opb).
Let's suppose XPAR_TFT_0_USE_DCR would be added by EDK (like XPAR_XINTC_USE_DCR
is used for the interrupt controller).

> Cheers,
> g.
> 

Thanks,
Andrei
