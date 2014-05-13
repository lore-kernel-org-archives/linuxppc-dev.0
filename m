Return-Path: <mpjohn@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5685C140080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 02:15:32 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mpjohn@us.ibm.com>;
 Tue, 13 May 2014 10:15:30 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1836F1FF0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 10:15:27 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id s4DECDe520119588
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 16:12:13 +0200
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4DGFQJ6026240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 10:15:26 -0600
In-Reply-To: <20140510024638.GA27540@us.ibm.com>
References: <20140510024638.GA27540@us.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug
 info
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Message-ID: <OF1EBFFD42.19D89CD2-ON86257CD7.00591CE2-86257CD7.00594B52@us.ibm.com>
From: Maynard Johnson <mpjohn@us.ibm.com>
Date: Tue, 13 May 2014 11:15:20 -0500
MIME-Version: 1.0
Content-type: multipart/alternative;
 Boundary="0__=09BBF644DFCA9A728f9e8a93df938690918c09BBF644DFCA9A72"
Cc: maynardj@linux.vnet.ibm.com, Michael Ellerman <michaele@au1.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Ulrich.Weigand@de.ibm.com, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=09BBF644DFCA9A728f9e8a93df938690918c09BBF644DFCA9A72
Content-type: text/plain; charset=US-ASCII

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> wrote on 05/09/2014
09:46:38 PM:

> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
> Cc: linux-kernel@vger.kernel.org, Anton Blanchard
> <anton@au1.ibm.com>, Ulrich.Weigand@de.ibm.com, Michael Ellerman
> <michaele@au1.ibm.com>, Maynard Johnson/Rochester/IBM@IBMUS,
> linuxppc-dev@lists.ozlabs.org
> Date: 05/09/2014 09:46 PM
> Subject: [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug
info
>
> [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug info

Acked-by: Maynard Johnson <maynardj@us.ibm.com>

Reviewed and tested.  Thanks, Suka.

-Maynard

>
> When saving the callchain on Power, the kernel conservatively saves
excess
> entries in the callchain. A few of these entries are needed in some cases
> but not others.
>
> Eg: the value in the link register (LR) is needed only when it holds the
> return address of a function. At other times it must be ignored.
>
> If the unnecessary entries are not ignored, we end up with duplicate arcs
> in the call-graphs.
>
> Use DWARF debug information to ignore the unnecessary entries.
>
> Callgraph before the patch:
>
>     14.67%          2234  sprintft  libc-2.18.so       [.] __random
>             |
>             --- __random
>                |
>                |--61.12%-- __random
>                |          |
>                |          |--97.15%-- rand
>                |          |          do_my_sprintf
>                |          |          main
>                |          |          generic_start_main.isra.0
>                |          |          __libc_start_main
>                |          |          0x0
>                |          |
>                |           --2.85%-- do_my_sprintf
>                |                     main
>                |                     generic_start_main.isra.0
>                |                     __libc_start_main
>                |                     0x0
>                |
>                 --38.88%-- rand
>                           |
>                           |--94.01%-- rand
>                           |          do_my_sprintf
>                           |          main
>                           |          generic_start_main.isra.0
>                           |          __libc_start_main
>                           |          0x0
>                           |
>                            --5.99%-- do_my_sprintf
>                                      main
>                                      generic_start_main.isra.0
>                                      __libc_start_main
>                                      0x0
>
> Callgraph after the patch:
>
>     14.67%          2234  sprintft  libc-2.18.so       [.] __random
>             |
>             --- __random
>                |
>                |--95.93%-- rand
>                |          do_my_sprintf
>                |          main
>                |          generic_start_main.isra.0
>                |          __libc_start_main
>                |          0x0
>                |
>                 --4.07%-- do_my_sprintf
>                           main
>                           generic_start_main.isra.0
>                           __libc_start_main
>                           0x0
>
> TODO:   For split-debug info objects like glibc, we can only determine
>    the call-frame-address only when both .eh_frame and .debug_info
>    sections are available. We should be able to determin the CFA
>    even without the .eh_frame section.
>
> Thanks to Ulrich Weigand for help with DWARF debug information.
>
> Fix suggested by Anton Blanchard.
>
> Reported-by: Maynard Johnson <maynard@us.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/arch/powerpc/Makefile                |   1 +
>  tools/perf/arch/powerpc/util/adjust-callchain.c | 278 +++++++++++++
> +++++++++++
>  tools/perf/config/Makefile                      |   5 +
>  tools/perf/util/callchain.h                     |  12 +
>  tools/perf/util/machine.c                       |  16 +-
>  5 files changed, 310 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/adjust-callchain.c
>
[snip]
--0__=09BBF644DFCA9A728f9e8a93df938690918c09BBF644DFCA9A72
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><tt><font size="2">Sukadev Bhattiprolu &lt;sukadev@linux.vnet.ibm.com&gt; wrote on 05/09/2014 09:46:38 PM:<br>
<br>
&gt; From: Sukadev Bhattiprolu &lt;sukadev@linux.vnet.ibm.com&gt;</font></tt><br>
<tt><font size="2">&gt; To: Arnaldo Carvalho de Melo &lt;acme@ghostprotocols.net&gt;, </font></tt><br>
<tt><font size="2">&gt; Cc: linux-kernel@vger.kernel.org, Anton Blanchard <br>
&gt; &lt;anton@au1.ibm.com&gt;, Ulrich.Weigand@de.ibm.com, Michael Ellerman <br>
&gt; &lt;michaele@au1.ibm.com&gt;, Maynard Johnson/Rochester/IBM@IBMUS, <br>
&gt; linuxppc-dev@lists.ozlabs.org</font></tt><br>
<tt><font size="2">&gt; Date: 05/09/2014 09:46 PM</font></tt><br>
<tt><font size="2">&gt; Subject: [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug info</font></tt><br>
<tt><font size="2">&gt; <br>
&gt; [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug info</font></tt><br>
<br>
<tt><font size="2">Acked-by: Maynard Johnson &lt;maynardj@us.ibm.com&gt;</font></tt><br>
<br>
<tt><font size="2">Reviewed and tested. &nbsp;Thanks, Suka.</font></tt><br>
<br>
<tt><font size="2">-Maynard</font></tt><br>
<tt><font size="2"><br>
&gt; <br>
&gt; When saving the callchain on Power, the kernel conservatively saves excess<br>
&gt; entries in the callchain. A few of these entries are needed in some cases<br>
&gt; but not others.<br>
&gt; <br>
&gt; Eg: the value in the link register (LR) is needed only when it holds the<br>
&gt; return address of a function. At other times it must be ignored.<br>
&gt; <br>
&gt; If the unnecessary entries are not ignored, we end up with duplicate arcs<br>
&gt; in the call-graphs.<br>
&gt; <br>
&gt; Use DWARF debug information to ignore the unnecessary entries.<br>
&gt; <br>
&gt; Callgraph before the patch:<br>
&gt; <br>
&gt; &nbsp; &nbsp; 14.67% &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2234 &nbsp;sprintft &nbsp;libc-2.18.so &nbsp; &nbsp; &nbsp; [.] __random<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --- __random<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|--61.12%-- __random<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|--97.15%-- rand<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --2.85%-- do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --38.88%-- rand<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |--94.01%-- rand<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;--5.99%-- do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0<br>
&gt; <br>
&gt; Callgraph after the patch:<br>
&gt; <br>
&gt; &nbsp; &nbsp; 14.67% &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;2234 &nbsp;sprintft &nbsp;libc-2.18.so &nbsp; &nbsp; &nbsp; [.] __random<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --- __random<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|--95.93%-- rand<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;__libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;|<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; --4.07%-- do_my_sprintf<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; generic_start_main.isra.0<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; __libc_start_main<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0<br>
&gt; <br>
&gt; TODO: &nbsp; For split-debug info objects like glibc, we can only determine<br>
&gt; &nbsp; &nbsp;the call-frame-address only when both .eh_frame and .debug_info<br>
&gt; &nbsp; &nbsp;sections are available. We should be able to determin the CFA<br>
&gt; &nbsp; &nbsp;even without the .eh_frame section.<br>
&gt; <br>
&gt; Thanks to Ulrich Weigand for help with DWARF debug information.<br>
&gt; <br>
&gt; Fix suggested by Anton Blanchard.<br>
&gt; <br>
&gt; Reported-by: Maynard Johnson &lt;maynard@us.ibm.com&gt;<br>
&gt; Signed-off-by: Sukadev Bhattiprolu &lt;sukadev@linux.vnet.ibm.com&gt;<br>
&gt; ---<br>
&gt; &nbsp;tools/perf/arch/powerpc/Makefile &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; 1 +<br>
&gt; &nbsp;tools/perf/arch/powerpc/util/adjust-callchain.c | 278 +++++++++++++<br>
&gt; +++++++++++<br>
&gt; &nbsp;tools/perf/config/Makefile &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; 5 +<br>
&gt; &nbsp;tools/perf/util/callchain.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;12 +<br>
&gt; &nbsp;tools/perf/util/machine.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;16 +-<br>
&gt; &nbsp;5 files changed, 310 insertions(+), 2 deletions(-)<br>
&gt; &nbsp;create mode 100644 tools/perf/arch/powerpc/util/adjust-callchain.c<br>
&gt; <br>
[snip]</font></tt></body></html>
--0__=09BBF644DFCA9A728f9e8a93df938690918c09BBF644DFCA9A72--
