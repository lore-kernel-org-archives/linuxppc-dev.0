Return-Path: <anju@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4971A039B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 05:52:32 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 27 Oct 2015 14:52:30 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E5C886E8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:40:39 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9RIqSAw56361004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 18:52:28 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9RIpTuW023015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 14:51:31 -0400
Subject: Re: [PATCH V2 0/3] perf/powerpc:Add ability to sample intr machine
 state in powerpc
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
 <CAOJe8K2FPkWMYPPX+aSNE01pQc6E9w7B0GVMHB8H4QfOvteDoA@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, acme@redhat.com, hemant@linux.vnet.ibm.com,
 dsahern@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, jolsa@redhat.com,
 khandual@linux.vnet.ibm.com, mpe@ellerman.id.au, anju@linux.vnet.ibm.com
From: Anju T <anju@linux.vnet.ibm.com>
Message-ID: <562FC7E3.7090101@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2015 00:22:19 +0530
MIME-Version: 1.0
In-Reply-To: <CAOJe8K2FPkWMYPPX+aSNE01pQc6E9w7B0GVMHB8H4QfOvteDoA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------060900090700080507070904"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060900090700080507070904
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Denis,
On Monday 26 October 2015 06:47 PM, Denis Kirjanov wrote:
> On 10/26/15, Anju T <anju@linux.vnet.ibm.com> wrote:
>> This short patch series add the ability to sample the interrupted
>> machine state for each hardware sample
> Hi,
> how can we check your patch series without testing details?

I have mentioned about the commands to test this feature in the 3rd 
patch of this series,but not detailed.

To test this patch,
Eg:

$perf record -I ls   // record machine state at interrupt
$perf script -D      //read the perf.data file

Sample output obtained for this patch / output looks like as follows:

179614739048 0xb90 [0x190]: PERF_RECORD_SAMPLE(IP, 0x1): 4130/4130: 
0xc0000000001dde88 period: 1 addr: 0

... intr regs: mask 0xfffffffffff ABI 64-bit

.... gpr0 0xc0000000001e6974

.... gpr1 0xc000001e48ad79a0

.... gpr2 0xc000000001523400

.... gpr3 0x1

.... gpr4 0xc000000fd7c76600

.... gpr5 0x29d1df51d8

.... gpr6 0x1e000000

.... gpr7 0x0

.... gpr8 0x0

.... gpr9 0x0

.... gpr10 0x1

.... gpr11 0x0

.... gpr12 0x24022822

.... gpr13 0xc00000000fee4c80

.... gpr14 0x0

.... gpr15 0xc0000000fcab3800

.... gpr16 0x0

.... gpr17 0xc000000ffa445000

.... gpr18 0xc000001e48ad78a0

.... gpr19 0xc000000001523400

.... gpr20 0xc0000000000a09bc

.... gpr21 0xc000001e3c11d100

.... gpr22 0xc0000000001e54a8

.... gpr23 0xc000000001523400

.... gpr24 0xc000001e48ad7850

.... gpr25 0xc000001e3c11d100

.... gpr26 0xc000001e48a71790

.... gpr27 0xfffffffffffffead

.... gpr28 0x0

.... gpr29 0xc000001e3c11d100

.... gpr30 0x1

.... gpr31 0x0

.... nip 0xc00000000000fe8c

.... msr 0x9000000000009032

.... orig_r3 0xc0000000001e6978

.... ctr 0xc00000000009e1f0

.... link 0xc0000000001e697c

.... xer 0x0

.... ccr 0x84022884

.... softe 0x1

.... trap 0xf01

.... dar 0x0

.... dsisr 0x300040060000004

.... result 0x0

... thread: :4130:4130

...... dso: /root/.debug/.build-id/82/8d2c7bac560dc9aac8bf6289f26504e22d6883

:4130 4130 179.614739: 1 cycles: c0000000001dde88 .perf_ctx_unlock 
(/boot/vmlinux)


0xd20 [0x190]: event: 9


>> Anju (3):
>>    perf/powerpc:add ability to sample intr machine state in power
>>    tools/perf:Map the ID values with register names
>>    perf/powerpc:add support for sampling intr machine state
>>
>>
>>   arch/powerpc/Kconfig                        |   1 +
>>   arch/powerpc/include/uapi/asm/perf_regs.h   |  55 +++++++++++++
>>   arch/powerpc/perf/Makefile                  |   1 +
>>   arch/powerpc/perf/perf_regs.c               |  87 ++++++++++++++++++++
>>   tools/perf/arch/powerpc/include/perf_regs.h | 118
>> ++++++++++++++++++++++++++++
>>   tools/perf/config/Makefile                  |   5 ++
>>   6 files changed, 267 insertions(+)
>>   create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
>>   create mode 100644 arch/powerpc/perf/perf_regs.c
>>   create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
>>
>> --
>> 2.1.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

Thanks and regards
Anju

--------------060900090700080507070904
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Denis,<br>
      On Monday 26 October 2015 06:47 PM, Denis Kirjanov wrote:<br>
    </div>
    <blockquote
cite="mid:CAOJe8K2FPkWMYPPX+aSNE01pQc6E9w7B0GVMHB8H4QfOvteDoA@mail.gmail.com"
      type="cite">
      <pre wrap="">On 10/26/15, Anju T <a class="moz-txt-link-rfc2396E" href="mailto:anju@linux.vnet.ibm.com">&lt;anju@linux.vnet.ibm.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">This short patch series add the ability to sample the interrupted
machine state for each hardware sample
</pre>
      </blockquote>
      <pre wrap="">
Hi,
how can we check your patch series without testing details?
</pre>
    </blockquote>
    <br>
    I have mentioned about the commands to test this feature in the 3rd
    patch of this series,but not detailed.<br>
    <br>
    To test this patch,<br>
    Eg:<br>
    <br>
    $perf record -I ls   // record machine state at interrupt<br>
    $perf script -D      //read the perf.data file<br>
    <br>
    Sample output obtained for this patch / output looks like as
    follows:<br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <p style="margin-bottom: 0cm; line-height: 100%">179614739048 0xb90
      [0x190]: PERF_RECORD_SAMPLE(IP, 0x1): 4130/4130:
      0xc0000000001dde88
      period: 1 addr: 0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">... intr regs: mask
      0xfffffffffff ABI 64-bit</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr0
      0xc0000000001e6974</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr1
      0xc000001e48ad79a0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr2
      0xc000000001523400</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr3 0x1</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr4
      0xc000000fd7c76600</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr5
      0x29d1df51d8</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr6
      0x1e000000</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr7 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr8 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr9 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr10 0x1</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr11 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr12
      0x24022822</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr13
      0xc00000000fee4c80</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr14 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr15
      0xc0000000fcab3800</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr16 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr17
      0xc000000ffa445000</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr18
      0xc000001e48ad78a0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr19
      0xc000000001523400</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr20
      0xc0000000000a09bc</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr21
      0xc000001e3c11d100</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr22
      0xc0000000001e54a8</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr23
      0xc000000001523400</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr24
      0xc000001e48ad7850</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr25
      0xc000001e3c11d100</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr26
      0xc000001e48a71790</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr27
      0xfffffffffffffead</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr28 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr29
      0xc000001e3c11d100</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr30 0x1</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... gpr31 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... nip
      0xc00000000000fe8c</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... msr
      0x9000000000009032</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... orig_r3
      0xc0000000001e6978</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... ctr
      0xc00000000009e1f0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... link
      0xc0000000001e697c</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... xer 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... ccr 0x84022884</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... softe 0x1</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... trap 0xf01</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... dar 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... dsisr
      0x300040060000004</p>
    <p style="margin-bottom: 0cm; line-height: 100%">.... result 0x0</p>
    <p style="margin-bottom: 0cm; line-height: 100%"> ... thread:
      :4130:4130</p>
    <p style="margin-bottom: 0cm; line-height: 100%"> ...... dso:
      /root/.debug/.build-id/82/8d2c7bac560dc9aac8bf6289f26504e22d6883</p>
    <p style="margin-bottom: 0cm; line-height: 100%"> :4130 4130
      179.614739: 1 cycles: c0000000001dde88
      .perf_ctx_unlock (/boot/vmlinux)</p>
    <p style="margin-bottom: 0cm; line-height: 100%"><br>
    </p>
    <p style="margin-bottom: 0cm; line-height: 100%">0xd20 [0x190]:
      event: 9</p>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.7.2 (Linux)">
    <style type="text/css">
		@page { margin: 2cm }
		p { margin-bottom: 0.25cm; line-height: 120% }
	</style><br>
    <blockquote
cite="mid:CAOJe8K2FPkWMYPPX+aSNE01pQc6E9w7B0GVMHB8H4QfOvteDoA@mail.gmail.com"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">
Anju (3):
  perf/powerpc:add ability to sample intr machine state in power
  tools/perf:Map the ID values with register names
  perf/powerpc:add support for sampling intr machine state


 arch/powerpc/Kconfig                        |   1 +
 arch/powerpc/include/uapi/asm/perf_regs.h   |  55 +++++++++++++
 arch/powerpc/perf/Makefile                  |   1 +
 arch/powerpc/perf/perf_regs.c               |  87 ++++++++++++++++++++
 tools/perf/arch/powerpc/include/perf_regs.h | 118
++++++++++++++++++++++++++++
 tools/perf/config/Makefile                  |   5 ++
 6 files changed, 267 insertions(+)
 create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
 create mode 100644 arch/powerpc/perf/perf_regs.c
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

--
2.1.0

_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a>
</pre>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
    Thanks and regards <br>
    Anju<br>
  </body>
</html>

--------------060900090700080507070904--
