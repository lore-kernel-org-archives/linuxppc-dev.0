Return-Path: <hollis@penguinppc.org>
Received: from flavatown.mail.pas.earthlink.net
	(flavatown.mail.pas.earthlink.net [207.217.120.148])
	by ozlabs.org (Postfix) with ESMTP id 6E4992BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 10:48:42 +1100 (EST)
Received: from pop-a065d01.pas.sa.earthlink.net (pop02.sprintmail.com
	[207.217.120.172])
	by flavatown.mail.pas.earthlink.net (8.11.7+Sun/8.11.6) with ESMTP id
	iAUNZKX08135
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Nov 2004 15:35:20 -0800 (PST)
Received: from user-0vvde2s.cable.mindspring.com ([63.246.184.92]
	helo=[10.0.0.2])
	by pop-a065d01.pas.sa.earthlink.net with esmtp (Exim 3.33 #1)
	id 1CZHWb-0007Lr-00
	for linuxppc-dev@ozlabs.org; Tue, 30 Nov 2004 15:35:13 -0800
Mime-Version: 1.0 (Apple Message framework v619)
In-Reply-To: <41ACE8B0.8090307@246tNt.com>
References: <41ACE8B0.8090307@246tNt.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79D19ADF-4328-11D9-9D55-000A95A0560C@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Tue, 30 Nov 2004 17:35:10 -0600
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Subject: Re: Implementing PowerManagment for a ppc target
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 30, 2004, at 3:40 PM, Sylvain Munaut wrote:
>
> I'm trying to implement Deep Sleep support for a ppc platform based on 
> 5200 and I have some questions :
>
> - How should I "integrate" it to linux, what the proper way ? I've 
> been trying #defining CONFIG_PM and
>   using the set_pm_ops operation but my call backs never get called 
> when doing a echo standby > /sys/power/state
> [...]
> I've been trying to look at Documentation/ and the sources but still 
> I'm not sure ...
>
>
> - How can I ensure that one of my function runs out of I Cache ? Some 
> pieces of assembler needs to not
>   acces memory when the last 'orders' are sent. Does just keeping it 
> small and aligned enough ?

You can see an example of the icache code in the linuxppc-2.4 tree, 
arch/ppc/platforms/ibm405lp_pmasm.S, after 
"_GLOBAL(ibm405lp_pm_command)". (You probably won't need to save and 
restore all CPU state though; that was needed because the 405LP was 
*really* powered down, not just paused.)

You can also see how that code is triggered from ibm405lp_pm.c . I 
don't think that's integrated with any laptop-style sleep work that's 
been done in the past 1.5 years, but it works with /proc/sys/sleep 
anyways (see Documentation/powerpc/405LP-sleep.txt).

-Hollis
