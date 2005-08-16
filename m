Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA5F67EEE
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 02:38:18 +1000 (EST)
In-Reply-To: <BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com>
References: <BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3b41d8d77ede2e44e1544ccfbb780ec5@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 16 Aug 2005 12:38:50 -0400
To: surendra.yadav@softdel.com
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 16, 2005, at 9:34 AM, Surendra Yadav wrote:

> I am writing framebuffer driver using SM501. This graphics driver chip 
> can
> drive CRT and TFT panel. I have written two seperate framebuffer 
> driver, one
> for CRT and one for TFT Panel.

I hope you didn't start from scratch.  There is already an SM501
framebuffer driver that works for both CRT and TFT panel.

> But I am not able to test both the devices. Any one of them work at a 
> time.
> I have created two files /dev/fb0 and /dev/fb1.

I don't think you want to do that unless you want two completely 
separate
images on the different outputs.  Normally, both the CRT and TFT display
the same images from the single framebuffer, and you use the capability
of the graphics engine to resize as necessary.

> .... These two can be open
> successfully and mmap is also successful from userspace. If I am 
> trying to
> write on fb0 and  fb1 with different data, they displayed on either 
> CRT or
> TFT panel.

If that's what you really want to do, I suspect you will have to 
register the driver
twice as two separate frame buffers and then manage that within the
single driver.  I would also consider allocating different areas of the 
single
frame buffer and then configure the planes to use the different areas 
within
the single buffer.

Good luck.


	-- Dan
