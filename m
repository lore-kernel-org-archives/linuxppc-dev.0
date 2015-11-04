Return-Path: <anju@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 477A51A0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 16:08:52 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 3 Nov 2015 22:08:49 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id CE2CB1FF002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 21:56:50 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA457UcT9109840
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 22:07:30 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA458bNA016486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Nov 2015 22:08:38 -0700
Subject: Re: [PATCH V3 2/3] perf/powerpc :add support for sampling intr
 machine state
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1446531002-16582-1-git-send-email-anju@linux.vnet.ibm.com>
 <1446531002-16582-3-git-send-email-anju@linux.vnet.ibm.com>
 <1446542195.23081.5.camel@ellerman.id.au>
Cc: maddy@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, acme@redhat.com, dsahern@gmail.com,
 jolsa@redhat.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
From: Anju T <anju@linux.vnet.ibm.com>
Message-ID: <563992D0.1030707@linux.vnet.ibm.com>
Date: Wed, 4 Nov 2015 10:38:32 +0530
MIME-Version: 1.0
In-Reply-To: <1446542195.23081.5.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------020002040605030400040108"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020002040605030400040108
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,
On Tuesday 03 November 2015 02:46 PM, Michael Ellerman wrote:
> On Tue, 2015-11-03 at 11:40 +0530, Anju T wrote:
>
>> The perf infrastructure uses a bit mask to find out
>> valid registers to display. Define a register mask
>> for supported registers defined in asm/perf_regs.h.
>> The bit positions also correspond to register IDs
>> which is used by perf infrastructure to fetch the register
>> values.CONFIG_HAVE_PERF_REGS enables
>> sampling of the interrupted machine state.
>> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
>> new file mode 100644
>> index 0000000..0520492
>> --- /dev/null
>> +++ b/arch/powerpc/perf/perf_regs.c
>> @@ -0,0 +1,92 @@
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/sched.h>
>> +#include <linux/perf_event.h>
>> +#include <linux/bug.h>
>> +#include <linux/stddef.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/perf_regs.h>
>> +
>> +#define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
>> +
>> +#define REG_RESERVED (~((1ULL << PERF_REG_POWERPC_MAX) - 1))
>> +
>> +static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR1, gpr[1]),
>> +	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR2, gpr[2]),
> <snip>
>
> I realise you're following the example of other architectures, but we have
> almost this exact same structure in ptrace.c, see regoffset_table.
>
> It would be really nice if we could share them between ptrace and perf.
>
> cheers


Thank you for reviewing the patch.

That is a great suggestion.

In ptrace.c the structure doesn't include ORIG_R3. So,in that case what 
should we do?




Thanks and Regard
Anju



--------------020002040605030400040108
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Michael,<br>
      On Tuesday 03 November 2015 02:46 PM, Michael Ellerman wrote:<br>
    </div>
    <blockquote cite="mid:1446542195.23081.5.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">On Tue, 2015-11-03 at 11:40 +0530, Anju T wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">The perf infrastructure uses a bit mask to find out
valid registers to display. Define a register mask
for supported registers defined in asm/perf_regs.h.
The bit positions also correspond to register IDs
which is used by perf infrastructure to fetch the register
values.CONFIG_HAVE_PERF_REGS enables
sampling of the interrupted machine state.
</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
new file mode 100644
index 0000000..0520492
--- /dev/null
+++ b/arch/powerpc/perf/perf_regs.c
@@ -0,0 +1,92 @@
+#include &lt;linux/errno.h&gt;
+#include &lt;linux/kernel.h&gt;
+#include &lt;linux/sched.h&gt;
+#include &lt;linux/perf_event.h&gt;
+#include &lt;linux/bug.h&gt;
+#include &lt;linux/stddef.h&gt;
+#include &lt;asm/ptrace.h&gt;
+#include &lt;asm/perf_regs.h&gt;
+
+#define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
+
+#define REG_RESERVED (~((1ULL &lt;&lt; PERF_REG_POWERPC_MAX) - 1))
+
+static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR1, gpr[1]),
+	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR2, gpr[2]),
</pre>
      </blockquote>
      <pre wrap="">
&lt;snip&gt;

I realise you're following the example of other architectures, but we have
almost this exact same structure in ptrace.c, see regoffset_table.

It would be really nice if we could share them between ptrace and perf.

cheers
</pre>
    </blockquote>
    <br>
    <br>
    Thank you for reviewing the patch.<br>
    <br>
    <meta http-equiv="content-type" content="text/html;
      charset=windows-1252">
    <p style="margin-bottom: 0cm; line-height: 100%">That is a great
      suggestion.</p>
    <p style="margin-bottom: 0cm; line-height: 100%">In ptrace.c the
      structure doesn't include ORIG_R3. So,in that case what should we
      do?</p>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.7.2 (Linux)">
    <style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.25cm; line-height: 120% }
	</style><br>
    <br>
    <blockquote cite="mid:1446542195.23081.5.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">
</pre>
    </blockquote>
    <br>
    Thanks and Regard <br>
    Anju<br>
    <br>
    <br>
  </body>
</html>

--------------020002040605030400040108--
