Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 6B3FD67A66
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 May 2006 01:12:21 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: regarding mvme6100 on kernel 2.6.13
Date: Tue, 30 May 2006 10:12:07 -0500
References: <20060530140929.88FBD3384B@ws7-3.us4.outblaze.com>
In-Reply-To: <20060530140929.88FBD3384B@ws7-3.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605301012.07607.bcook@bpointsys.com>
Cc: "Kiran Kumar.A" <kiranf5@lycos.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 30 May 2006 09:09, Kiran Kumar.A wrote:
> Hi all,
>
> I'm porting mvme6100 for 2.6.13.
> But its hanging after "Now Booting the kernel.."
>
> Can anybody guide me in this regard.
>
> thanks and regards

Eh, it's probably not hanging at all - you're just not seeing anything because 
the device naming scheme changed and the serial console not getting 
initialized correctly. Be sure that in your platform_notify function has 
a '.' in the platform device name - this was added around 2.6.11 or so.

An example from another board I have:

static int xes_mv64x60_platform_notify(struct device *dev)
{
    static struct {
        char *bus_id;
        void ((*rtn) (struct platform_device * pdev));
    } dev_map[] = {
#ifdef CONFIG_SERIAL_MPSC
        {
        MPSC_CTLR_NAME ".0", xes_mv64x60_fixup_mpsc_pdata}, {
        MPSC_CTLR_NAME ".1", xes_mv64x60_fixup_mpsc_pdata},
#endif

}

Also, be sure to enable early boot messages - they help a lot. Also, don't 
overlook setting console=ttyMM0,9600 in the kernel args.

 - Brent
