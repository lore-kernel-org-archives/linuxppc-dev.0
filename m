Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 7719BDDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 05:16:56 +1100 (EST)
Message-ID: <47505206.9080605@qstreams.com>
Date: Fri, 30 Nov 2007 13:10:14 -0500
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Stuart Hodgson <stuart@quadrics.com>
Subject: Re: Semaphores in eldk4.1
References: <47503B5A.6090604@quadrics.com>
In-Reply-To: <47503B5A.6090604@quadrics.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

HI Stuart,

Stuart Hodgson wrote:
> Hi,
>
> I have been suing the eldk4.1 tool chain for a few months now and have 
> not not encountered any problems with building until now. I build for 
> two slightly different archs, ppc_85xx and ppx_82xx.
>
> The problem I have come up against is related to some of the semaphore 
> functions in semaphore.h, namely sem_wait, sem_post. This was originally 
> noticed in a third party driver I am porting from one board to another 
> but a small test program has shown the same results.
>
> Calls to these functions on the ppc_82xx platform return -1 with an 
> error code of 38, in this case meaning  ENOSYS (not implemented). On the 
> ppc_85xx the same program executes fine, thus I conclude that it is 
> specific to the libc-2.3.5 for ppc_82xx. Has anyone else come across 
> this problem, I did find one thread but there was no conclusion listed.
>
>   
These work fine for me with ppc_6xx architecture and ELDK 4.1, although 
they didn't with ELDK 4.0. In that case, I was getting ENOSYS on 
sem_open() and sem_init(). Do these functions return 0 for you? I assume 
you're using a kernel that supports POSIX semaphores (I think that 
started at 2.6.12) and that you're using the glibc version of ELDK and 
not ulibc.
> I also can not find anything stating that these functions are not 
> implemented for the 82xx arch compared with others for the eldk4.1
>
> Thanks
>
> Stuart
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
regards,
Ben
