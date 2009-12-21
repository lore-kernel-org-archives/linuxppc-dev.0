Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id BADB4B6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 08:12:16 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: update ibm,client-architecture
In-reply-to: <4B2FBB3F.8030703@austin.ibm.com>
References: <1261170452.8134.13.camel@jschopp-laptop>
	<29526.1261353566@neuling.org> <4B2FBB3F.8030703@austin.ibm.com>
Date: Tue, 22 Dec 2009 08:12:15 +1100
Message-ID: <7024.1261429935@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >> Subject: Re: [PATCH] powerpc: update ibm,client-architecture
> >>     
> >
> > Please give this a more appropriate name.  
> >   
> Any suggestions?

Something that's more descriptive of what the patch does.  Say "Add
max CPU nodes field to ibm,client-architecture call"

> >   
> >> In order to boot with more than 64 cores on machines that support the
> >> ibm,client-architecture RTAS call a new field has been added to the
> >> structure.  This patch updates that field and adds a few others in the
> >> process.
> >>     
> >
> > Please detail what these are here.
> >   
> OK.
> >> +	W(NR_CPUS/4),			/* max cores supported */

FYI reading the PAPR, this comment should technically be "max 'cpu'
nodes presented".

> >>     
> >
> > 4?
> >
> >   
> 4 is the new 2.  

I'd still be asking what 2 is.  It's needs a #define to make clearer
what you are doing.

> Since you don't know the actual threads per core at 
> this point in boot you have to be conservative and go with the maximum 
> number of any processor.  See page 4 of these charts:
> http://www.power.org/events/powercon09/taiwan09/IBM_Overview_POWER7.pdf

I don't think hard wiring 4 in here is right. If we are booting a
machine with SMT2, we will put only half the number of cores that we can
handle in this field.  This is going to break a lot of machines where
people have compiled with NR_CPUS = thread number.

I think you just want to put NR_CPUS here.  

Mikey

> >
> >
> > Can we do this now or remove the comment.  Maybe UTS_RELEASE or
> > something like that.
> >   
> I'll just remove the comment for now.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
