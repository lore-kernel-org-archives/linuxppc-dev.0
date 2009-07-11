Return-Path: <hofrat@hofr.at>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 098DCB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Jul 2009 20:12:22 +1000 (EST)
Received: from mail.hofr.at (unknown [212.69.189.236])
	by ozlabs.org (Postfix) with ESMTP id 8E17DDDDF0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Jul 2009 20:12:21 +1000 (EST)
Date: Sat, 11 Jul 2009 12:05:48 +0200
From: Nicholas Mc Guire <mcguire@lzu.edu.cn>
To: G?nter Leonhardt <Guenter.Leonhardt@men.de>
Subject: Re: Memory usage of a process
Message-ID: <20090711100548.GB15785@opentech.at>
References: <D0B748CCD5DF144CA5C56A9D860A31341DE613@men-exch1.intra.men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D0B748CCD5DF144CA5C56A9D860A31341DE613@men-exch1.intra.men.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 10 Jul 2009, G?nter Leonhardt wrote:

>  
> Hello,
> analysing the memory usage of a process, I found some questions.
> I'am using a system with 128 MB physical RAM, no disk, 2.6.27 kernel.
> 
> Running top, I see 38 MB in use, 90 MB free, but a VSZ for my process of 158 MB.
> Looking at /proc/<pid>/maps, I see that the process uses 140 MB without shared libs.
> 
> So how it is possible that the process can allocate more memory than there is, without posibility of swapping?
>
> Why said top that 90 MB free? Does the kernel serve the allocation only if ist really used?
> 

an allocation does not actually set aside any physical ram (unless you do an mlock and actually touch the memory) - it only reserves virtual memory areas (vma's) and when your process accesses the respective address the OS page-faults and prvides the physical RAM as needed (and possible) - if you have no swap and you allow overcommitting of memory then you are potentially going to see this application failing as soon as it tries to utilize the memory.

This can be set in the system via /proc/sys/vm/overcommit_memory (see
linux/Documentation/vm/overcommit-accounting for details).
 
hofrat
