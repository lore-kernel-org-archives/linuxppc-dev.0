Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e3.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBF012C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 18:41:43 +1000 (EST)
Received: from /spool/local
 by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Fri, 27 Jul 2012 04:41:18 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8B13438C8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 04:41:06 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6R8f6Xh089766
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 04:41:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6R8f4tE017319
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 05:41:05 -0300
Date: Fri, 27 Jul 2012 14:10:55 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v3 2/2] powerpc: Uprobes port to powerpc
Message-ID: <20120727084055.GA6679@linux.vnet.ibm.com>
References: <20120726051902.GA29466@in.ibm.com>
 <20120726052029.GB29466@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20120726052029.GB29466@in.ibm.com>
Cc: peterz@infradead.org, lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Ananth N Mavinakayanahalli <ananth@in.ibm.com> [2012-07-26 10:50:29]:

> From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> 
> This is the port of uprobes to powerpc. Usage is similar to x86.
> 
> [root@xxxx ~]# ./bin/perf probe -x /lib64/libc.so.6 malloc
> Added new event:
>   probe_libc:malloc    (on 0xb4860)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_libc:malloc -aR sleep 1
> 
> [root@xxxx ~]# ./bin/perf record -e probe_libc:malloc -aR sleep 20
> [ perf record: Woken up 22 times to write data ]
> [ perf record: Captured and wrote 5.843 MB perf.data (~255302 samples) ]
> [root@xxxx ~]# ./bin/perf report --stdio
> ...
> 
> # Samples: 83K of event 'probe_libc:malloc'
> # Event count (approx.): 83484
> #
> # Overhead       Command  Shared Object      Symbol
> # ........  ............  .............  ..........
> #
>     69.05%           tar  libc-2.12.so   [.] malloc
>     28.57%            rm  libc-2.12.so   [.] malloc
>      1.32%  avahi-daemon  libc-2.12.so   [.] malloc
>      0.58%          bash  libc-2.12.so   [.] malloc
>      0.28%          sshd  libc-2.12.so   [.] malloc
>      0.08%    irqbalance  libc-2.12.so   [.] malloc
>      0.05%         bzip2  libc-2.12.so   [.] malloc
>      0.04%         sleep  libc-2.12.so   [.] malloc
>      0.03%    multipathd  libc-2.12.so   [.] malloc
>      0.01%      sendmail  libc-2.12.so   [.] malloc
>      0.01%     automount  libc-2.12.so   [.] malloc
> 
> Patch applies on the current master branch of Linus' tree (bdc0077af).
> The trap_nr addition patch is a prereq.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com> 
 
