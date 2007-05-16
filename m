Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 797D9DDF31
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:07:58 +1000 (EST)
Message-ID: <464B4876.7040902@am.sony.com>
Date: Wed, 16 May 2007 11:07:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Edward Strong <edo@onkeh.net>
Subject: Re: PS3 restart crash, SCSI cache sync
References: <29744.81.170.114.242.1179319943.squirrel@onkeh.net>
In-Reply-To: <29744.81.170.114.242.1179319943.squirrel@onkeh.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Edward Strong wrote:
> I've had this problem for a while but I waited until the 1.3 release kit
> emerged before raising this, unfortunately it has not resolved my problem.
> 
> When I reboot the PS3, the last thing to be displayed is:

Please send this kind of PS3 specific post to the cbe-oss-dev mailing
list next time:

  cbe-oss-dev@ozlabs.org
  https://ozlabs.org/mailman/listinfo/cbe-oss-dev


> Synchronizing SCSI cache for disk sda
> Synchronizing SCSI cache for disk sda
> 
> Then I get a full hardware crash and have to hit the power switch at the
> back.  

I guess that is not true.  The polling code for the vuart wasn't working
properly so it was just spinning.  Please press the power button for about 10 sec.
The HV will gain control and shutdown the lpar.

If I just do a shutdown, this works fine.  This error is
> reproducible running both Gentoo and FC6.  I am using a 120gb Fujitsu
> drive.  Does anyone know why this might be happening?

I just added power button support to ps3-linux.git the other day.  Either update
to that, or backport the fix to your kernel.

-Geoff
