Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp5.aruba.it (smtpd3.aruba.it [62.149.128.208])
	by ozlabs.org (Postfix) with SMTP id 6D4B4DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 02:40:58 +1100 (EST)
Subject: Re: Ethernet fails on MPC5200 based target
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <45A4FDAF.8020909@246tNt.com>
References: <1168439212.5271.70.camel@localhost.localdomain>
	<45A4FDAF.8020909@246tNt.com>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 16:41:51 +0100
Message-Id: <1168443711.5271.87.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain! Thanks for quick reply!
I'll try go give you more details.

> Could you tell me exactly what kernel you use from me ? (a commit id
> would do)

Sorry but I have very poor git knowledge. Hope the following "git log"
output answers your question. Otherwise please tell me how to get the
correct commit id you need.

commit 7cdaf877678d49e9f8a79d102a12eae7d9772f4b
Merge: a7e235cba9aa805aab4614f2029924ee2d1a1cb7 380c897f96e9084082e538f34623ce4e78935915
Author: Andrea Galbusera <gizero@andreagal.localdomain>
Date:   Tue Dec 12 10:41:21 2006 +0100

    Merge branch 'bestcomm' of http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx

commit a7e235cba9aa805aab4614f2029924ee2d1a1cb7
Merge: f0aca16fba1f102dd2c33ff8b8bb66ec7f830ee2 af4f75fd6c64917cd3e21f28b17ed49aeac06075
Author: Sylvain Munaut <tnt@246tNt.com>
Date:   Sun Feb 5 17:13:29 2006 +0100

    Merge with git+ssh://gitbits.246tNt.com/home/users/tnt/gitbits/linux-2.6-mpc52xx.git

    (to bring recent cpu init changes into the ide branch)


> And did you write your own platform file ?
> Maybe some things (like xlb pipelining, cache snooping, ...) is not properly
> setup in you platform support code ?

No, I did not. I use the original platform file
in ./arch/ppc/platforms/lite5200.c. At moment I only had to add
initialization code for a few more UARTs: no other changes from
original. In fact this is one of the file showing differences between
Denx tree and yours. I'll experiment a while reverting those changes.

> 
> Or maybe since the ethernet code currently only "knows" about the intel phy,
> something is wrong in the "generic" phy code included in the driver itself.

Could you please clarify this concept a little more? I still have an
incomplete undertanding of the many source components needed to make eth
work. I'm focusing on understanding why Denx code works while yours/ltib
fails, but this may not be the best way to walk on...

Andrea
