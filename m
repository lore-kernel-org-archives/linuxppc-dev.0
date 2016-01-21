Return-Path: <anju@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC3FC1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 20:57:50 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Thu, 21 Jan 2016 02:57:48 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 4EE253E40041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 02:57:43 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0L9vhgv23789740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 02:57:43 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0L9vgKW030034
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 02:57:43 -0700
Subject: Re: [PATCH V10 2/4] perf/powerpc: add support for sampling intr
 machine state
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1452508104-16507-1-git-send-email-anju@linux.vnet.ibm.com>
 <1452508104-16507-3-git-send-email-anju@linux.vnet.ibm.com>
 <1453286426.14751.19.camel@ellerman.id.au>
Cc: khandual@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Anju T <anju@linux.vnet.ibm.com>
Message-ID: <56A0AB91.6070104@linux.vnet.ibm.com>
Date: Thu, 21 Jan 2016 15:27:37 +0530
MIME-Version: 1.0
In-Reply-To: <1453286426.14751.19.camel@ellerman.id.au>
Content-Type: multipart/alternative;
 boundary="------------020204030007030200040404"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020204030007030200040404
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi mpe,
On Wednesday 20 January 2016 04:10 PM, Michael Ellerman wrote:
> On Mon, 2016-01-11 at 15:58 +0530, Anju T wrote:
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 9a7057e..c4ce60d 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -119,6 +119,7 @@ config PPC
>>   	select GENERIC_ATOMIC64 if PPC32
>>   	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>   	select HAVE_PERF_EVENTS
>> +	select HAVE_PERF_REGS
>>   	select HAVE_REGS_AND_STACK_ACCESS_API
>>   	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>>   	select ARCH_WANT_IPC_PARSE_VERSION
>> diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
>> new file mode 100644
>> index 0000000..d32581763
>> --- /dev/null
>> +++ b/arch/powerpc/perf/perf_regs.c
> ...
>> +
>> +u64 perf_reg_abi(struct task_struct *task)
>> +{
>> +	return PERF_SAMPLE_REGS_ABI_64;
> What is this value used for exactly?
>
> It seems like on 32-bit kernels we should be returning PERF_SAMPLE_REGS_ABI_32.


Values to determine ABI of the registers dump.

enum perf_sample_regs_abi {

PERF_SAMPLE_REGS_ABI_NONE = 0,

PERF_SAMPLE_REGS_ABI_32 = 1,

PERF_SAMPLE_REGS_ABI_64 = 2,

};


Initially the ABI is set as NONE. So when we enable 
PERF_SAMPLE_REGS_INTR we need to get the correspodning ABI. This in turn 
required for ..

void perf_output_sample(struct perf_output_handle *handle,
         if (sample_type & PERF_SAMPLE_TRANSACTION)
                 perf_output_put(handle, data->txn);

        if (sample_type & PERF_SAMPLE_REGS_INTR) {
                u64 abi = data->regs_intr.abi;
                /*
                 * If there are no regs to dump, notice it through
                 * first u64 being zero (PERF_SAMPLE_REGS_ABI_NONE).
                 */
                perf_output_put(handle, abi);

                if (abi) {
                        u64 mask = event->attr.sample_regs_intr;

                        perf_output_sample_regs(handle,
data->regs_intr.regs,
                                                mask);
                }
        }



Here as you suggested we may need to pass the right ABI for 64 and 32 bit.


Thanks and Regards

Anju




>
>> +}
>> +
>> +void perf_get_regs_user(struct perf_regs *regs_user,
>> +			struct pt_regs *regs,
>> +			struct pt_regs *regs_user_copy)
>> +{
>> +	regs_user->regs = task_pt_regs(current);
>> +	regs_user->abi  = perf_reg_abi(current);
>> +}
> cheers
>


--------------020204030007030200040404
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi mpe,<br>
      On Wednesday 20 January 2016 04:10 PM, Michael Ellerman wrote:<br>
    </div>
    <blockquote cite="mid:1453286426.14751.19.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">On Mon, 2016-01-11 at 15:58 +0530, Anju T wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9a7057e..c4ce60d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,6 +119,7 @@ config PPC
 	select GENERIC_ATOMIC64 if PPC32
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS &amp;&amp; PPC_BOOK3S_64
 	select ARCH_WANT_IPC_PARSE_VERSION
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
new file mode 100644
index 0000000..d32581763
--- /dev/null
+++ b/arch/powerpc/perf/perf_regs.c
</pre>
      </blockquote>
      <pre wrap="">...
</pre>
      <blockquote type="cite">
        <pre wrap="">+
+u64 perf_reg_abi(struct task_struct *task)
+{
+	return PERF_SAMPLE_REGS_ABI_64;
</pre>
      </blockquote>
      <pre wrap="">
What is this value used for exactly?

It seems like on 32-bit kernels we should be returning PERF_SAMPLE_REGS_ABI_32.</pre>
    </blockquote>
    <br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <p style="margin-bottom: 0cm; line-height: 100%">Values to determine
      ABI of the registers dump.</p>
    <p style="margin-bottom: 0cm; line-height: 100%"> </p>
    <p style="margin-bottom: 0cm; line-height: 100%">enum
      perf_sample_regs_abi {</p>
    <p style="margin-bottom: 0cm; line-height: 100%">
      PERF_SAMPLE_REGS_ABI_NONE = 0,</p>
    <p style="margin-bottom: 0cm; line-height: 100%">
      PERF_SAMPLE_REGS_ABI_32 = 1,</p>
    <p style="margin-bottom: 0cm; line-height: 100%">
      PERF_SAMPLE_REGS_ABI_64 = 2,</p>
    <p style="margin-bottom: 0cm; line-height: 100%">};</p>
    <p style="margin-bottom: 0cm; line-height: 100%"><br>
    </p>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.7.2 (Linux)">
    <style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.25cm; line-height: 120% } </style>Initially the
    ABI is set as NONE. So when we enable PERF_SAMPLE_REGS_INTR we need
    to get the correspodning ABI. This in turn required for ..<br>
    <br>
    void perf_output_sample(struct perf_output_handle *handle,<br>
            if (sample_type &amp; PERF_SAMPLE_TRANSACTION)<br>
                    perf_output_put(handle, data-&gt;txn);<br>
     <br>
           if (sample_type &amp; PERF_SAMPLE_REGS_INTR) {<br>
                   u64 abi = data-&gt;regs_intr.abi;<br>
                   /*<br>
                    * If there are no regs to dump, notice it through<br>
                    * first u64 being zero (PERF_SAMPLE_REGS_ABI_NONE).<br>
                    */<br>
                   perf_output_put(handle, abi);<br>
    <br>
                   if (abi) {<br>
                           u64 mask = event-&gt;attr.sample_regs_intr;<br>
    <br>
                           perf_output_sample_regs(handle,<br>
                                                  
    data-&gt;regs_intr.regs,<br>
                                                   mask);<br>
                   }<br>
           }<br>
    <br>
    <br>
    <br>
    Here as you suggested we may need to pass the right ABI for 64 and
    32 bit.<br>
    <br>
    <br>
    Thanks and Regards<br>
    <br>
    Anju<br>
    <br>
    <br>
    <br>
    <br>
    <blockquote cite="mid:1453286426.14751.19.camel@ellerman.id.au"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	regs_user-&gt;regs = task_pt_regs(current);
+	regs_user-&gt;abi  = perf_reg_abi(current);
+}
</pre>
      </blockquote>
      <pre wrap="">
cheers

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------020204030007030200040404--
