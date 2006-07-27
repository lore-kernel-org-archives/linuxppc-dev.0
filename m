Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8583D67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 21:27:50 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Patrick J. Kelsey'" <KelseyPJ@fairmountautomation.com>,
	<linuxppc-dev@ozlabs.org>
Subject: RE: Can 750 user-mode binaries run on a 603e core?
Date: Thu, 27 Jul 2006 13:27:40 +0200
Message-ID: <002701c6b16f$af134640$99dfdfdf@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <A958F7B12F59EC408E904A912CDE3DAE3D6A0A@cvn68.fairmountautomation.com>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The 603/603e has 1 integer unit. The 604/604e and 7xx lines had
2.

Basically if you optimize for the 750 it may queue up integer
ops assuming there is room to execute them simultaneously, when
in fact there isn't.

But as kumar said, userspace is absolutely positively identical,
the chips from 603e to the latest G4 are entirely binary
compatible for integer and FPU code. Most people just optimize
for the 603e and let the CPU handle the rest.

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
 

> -----Original Message-----
> From: linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+matt=genesi-usa.com@ozlabs.org] 
> On Behalf Of Patrick J. Kelsey
> Sent: Thursday, July 27, 2006 5:54 AM
> To: linuxppc-dev@ozlabs.org
> Subject: RE: Can 750 user-mode binaries run on a 603e core?
> 
> (sorry about that last one. had a bit of trouble with a 
> certain web based mail client...) 
>  
> Thanks for the reply, Kumar.
>  
> That sounds encouraging.  One of the things I was worried 
> about with scheduling differences would be a differing number 
> of branch delay slots between the two core versions.  I'm 
> still a bit new to the details of the PowerPC architecture, 
> and at this point I'm not even sure if there are branch delay 
> slots, although it does seem from my reading that the 603e 
> and 750 pipelines are the same, in which case there would 
> ceratinly be no worries here.
>  
> At this point, I'm not concerned so much about an inefficient 
> schedule resulting from running -mcpu=750 code on a 603e as 
> long as the execution is correct.
>  
> Pat
>  
> 
> 	-----Original Message----- 
> 	From: 
> linuxppc-dev-bounces+kelseypj=fairmountautomation.com@ozlabs.o
> rg on behalf of Kumar Gala 
> 	Sent: Wed 7/26/2006 8:04 PM 
> 	To: Patrick J. Kelsey 
> 	Cc: linuxppc-dev@ozlabs.org 
> 	Subject: Re: Can 750 user-mode binaries run on a 603e core?
> 	
> 	
> 
> 
> 	On Jul 26, 2006, at 5:27 PM, Patrick J. Kelsey wrote:
> 	
> 	> Hi,
> 	>
> 	> If have user-mode binaries built for a 750 core, say 
> with gcc -
> 	> mcpu=750, should I expect them to run on a 603e core? 
>  Would I have 
> 	> to worry about unsupported instructions or 
> instruction scheduling 
> 	> issues?
> 	>
> 	> If there's a better list for this question, please advise.
> 	
> 	Sure, there isn't different in the user space instruction sets 
> 	between the 750 and 603e core.  The -mcpu is only tweaking 
> 	instruction scheduling and making it specific for the 750.  The 
> 	instruction scheduling differences aren't that huge if 
> memory serves 
> 	me correctly.  The 750 probably takes fewer cycles on 
> multiple and 
> 	divides.  I forget if the 750 has any additional 
> execution units that 
> 	the 603e didn't have (additional integer units, etc.).
> 	
> 	- kumar
> 	_______________________________________________
> 	Linuxppc-dev mailing list
> 	Linuxppc-dev@ozlabs.org
> 	https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 	
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
