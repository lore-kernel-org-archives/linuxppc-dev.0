Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sP4Pb1ydtzDqXr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Aug 2016 09:25:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7UNNYXd107633
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:25:20 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25536bfnww-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:25:20 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 30 Aug 2016 20:25:18 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 3D1421DC006D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 19:25:05 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7UNPEd723462354
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 20:25:14 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7UNPCGJ007097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 20:25:14 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>,
 David Laight <David.Laight@aculab.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/2] extend kexec_file_load system call
Date: Tue, 30 Aug 2016 20:25:08 -0300
In-Reply-To: <20160818102112.GB27045@leverpostej>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20160818102112.GB27045@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <2408856.dZN5fLyePL@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mark,

Sorry for taking this long to respond. I've been focusing on getting my 
kexec_file_load and kexec buffer hand-over series in shape.

Am Donnerstag, 18 August 2016, 11:21:13 schrieb Mark Rutland:
> On Thu, Aug 11, 2016 at 08:03:56PM -0300, Thiago Jung Bauermann wrote:
> > Device tree blob must be passed to a second kernel on DTB-capable
> > archs, like powerpc and arm64, but the current kernel interface
> > lacks this support.
> > 
> > This patch extends kexec_file_load system call by adding an extra
> > argument to this syscall so that an arbitrary number of file descriptors
> > can be handed out from user space to the kernel.
> > 
> > See the background [1].
> > 
> > Please note that the new interface looks quite similar to the current
> > system call, but that it won't always mean that it provides the "binary
> > compatibility."
> > 
> > [1] http://lists.infradead.org/pipermail/kexec/2016-June/016276.html
> 
> As with the original posting, I have a number of concerns, and I'm
> really not keen on this.

Thanks for laying out out the reasons for your objection. That's very 
helpful.

> * For typical usecases, I do not believe that this is necessary (at
>   least for arm64), and generally do not believe that it should be
>   necessary for a user to manipulate the DTB (much like the user need
>   not manipulate ACPI tables or other FW data structures).
> 
>   Other than (potentially) the case of Linux as a flashed-in bootloader,
>   I don't see a compelling case for modifying the DTB that could not be
>   accomplished in-kernel. For that case, if truly necessary, I think
>   that we can get away with something simpler.

Yes, this is the case I am aiming for. I'll experiment with a couple of 
different approaches and see how well they perform.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
