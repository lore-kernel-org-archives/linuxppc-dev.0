Return-Path: <windenntw@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 4D4682BEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Dec 2004 08:23:00 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 67so183080wri
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2004 13:22:59 -0800 (PST)
Message-ID: <69304d11041217131620036e56@mail.gmail.com>
Date: Fri, 17 Dec 2004 22:16:19 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Kendall Bennett <KendallB@scitechsoft.com>
In-Reply-To: <41B9A33A.26557.5DDD7EC8@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <41B9A33A.26557.5DDD7EC8@localhost>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Write Combining for PowerPC?
Reply-To: Antonio Vargas <windenntw@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 10 Dec 2004 13:23:06 -0800, Kendall Bennett
<KendallB@scitechsoft.com> wrote:
> Hi Guys,
> 
> We are working on some PowerPC machines and noticed that the boxes don't
> appear to support the equivalent of Write Combining that we get on x86
> boxes. Copies to Video Memory on our Motorola Sandpoint box run about
> 10Mb/s, which is terribly, terribly slow!
> 
> Does anyone know if it is possible to do something similar to Write
> Combining for the PowerPC architecture, to speed up CPU access to the
> linear framebuffer? Part of the problem is that for video overlay support

hmmm... G4 processors will do write-combining when you write two
cachelines just one after the other... there is a write-queue on the
cpu and when there is 1 write on the queue and you add another one for
the next cacheline, it will automatically merge the write. Also, if
you manage to complete a sector, then he knows you don't need to
read-then-write the memory and just issues a "kill-this-cacheline" on
the bus instead of "please-i-need-exclusive-access-for-this-cacheline"

> (not motion compensation) you have to dump the entire YUV frame into
> video memory for the hardware overlay, and even on a 1GHz PPC box playing
> an MPEG2 stream is not possible as X takes up over 80% of the CPU just to
> copy the YUV data to video memory!
> 
> Obviously bus mastering will help solve this problem, but it would be
> better if there was a way to enabling faster CPU access to the
> framebuffer as well.

bus mastering is DMA-ing from system memory to gfxcard memory?
 
> Regards,
> 
> ---
> Kendall Bennett
> Chief Executive Officer
> SciTech Software, Inc.
> Phone: (530) 894 8400
> http://www.scitechsoft.com
> 
> ~ SciTech SNAP - The future of device driver technology! ~
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 


-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
