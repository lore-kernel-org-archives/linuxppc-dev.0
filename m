Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B961A0C92
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 21:24:39 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 20:24:37 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 086402BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 21:24:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5AOPTA50790510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 21:24:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5AO12r020755
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 21:24:01 +1100
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
To: David Gibson <dgibson@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <5639FB4A.7020508@linux.vnet.ibm.com> <563A0E2B.4090404@redhat.com>
 <20151105123243.47dda843@voom.fritz.box>
Cc: thuth@redhat.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Message-ID: <563B2E26.6050704@linux.vnet.ibm.com>
Date: Thu, 5 Nov 2015 15:53:34 +0530
MIME-Version: 1.0
In-Reply-To: <20151105123243.47dda843@voom.fritz.box>
Content-Type: multipart/alternative;
 boundary="------------090000000709080102090808"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090000000709080102090808
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/05/2015 07:02 AM, David Gibson wrote:
> On Wed, 4 Nov 2015 14:54:51 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>
>>
>> On 04/11/2015 13:34, Hari Bathini wrote:
>>> On 10/16/2015 12:30 AM, Laurent Vivier wrote:
>>>> On kexec, all secondary offline CPUs are onlined before
>>>> starting the new kernel, this is not done in the case of kdump.
>>>>
>>>> If kdump is configured and a kernel crash occurs whereas
>>>> some secondaries CPUs are offline (SMT=off),
>>>> the new kernel is not able to start them and displays some
>>>> "Processor X is stuck.".
>>>>
>>>> Starting with POWER8, subcore logic relies on all threads of
>>>> core being booted. So, on startup kernel tries to start all
>>>> threads, and asks OPAL (or RTAS) to start all CPUs (including
>>>> threads). If a CPU has been offlined by the previous kernel,
>>>> it has not been returned to OPAL, and thus OPAL cannot restart
>>>> it: this CPU has been lost...
>>>>
>>>> Signed-off-by: Laurent Vivier<lvivier@redhat.com>
>>>
>>> Hi Laurent,
>> Hi Hari,
>>
>>> Sorry for jumping too late into this.
>> better late than never :)
>>
>>> Are you seeing this issue even with the below patches:
>>>
>>> pseries:
>>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c1caae3de46a072d0855729aed6e793e536a4a55
> Unfortunately, this is unlikely to be relevant - this fixes a failure
> while setting up the kexec.  The problem we see occurs once we've
> booted the second kernel and it's attempting to bring up secondary CPUs.
>
>>> opal/powernv:
>>> https://github.com/open-power/skiboot/commit/9ee56b5
>> Very interesting. Is there a way to have a firmware with the fix ?
>  From Laurent's analysis of the crash, I don't think this will be


> relevant either, but I'm not sure.  It would be very interesting to
> know which (if any) released firmwares include this patch so we can
> test it.

Hi Laurent/David,

I am not so sure on this. While I get back on this, can you confirm you are
seeing the issue in both PowerVM (pseries) and baremetal (powernv). What is
the kernel version where the issue is seen for PowerVM and/or baremetal.
Also, for baremetal, can you mention the OPAL version on which the issue is
reproducible. If a bug is raised for this, I would be happy to be 
pointed to,
to get more information on this.

Thanks
Hari

>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------090000000709080102090808
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 11/05/2015 07:02 AM, David Gibson
      wrote:<br>
    </div>
    <blockquote cite="mid:20151105123243.47dda843@voom.fritz.box"
      type="cite">
      <pre wrap="">On Wed, 4 Nov 2015 14:54:51 +0100
Laurent Vivier <a class="moz-txt-link-rfc2396E" href="mailto:lvivier@redhat.com">&lt;lvivier@redhat.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">

On 04/11/2015 13:34, Hari Bathini wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On 10/16/2015 12:30 AM, Laurent Vivier wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">On kexec, all secondary offline CPUs are onlined before
starting the new kernel, this is not done in the case of kdump.

If kdump is configured and a kernel crash occurs whereas
some secondaries CPUs are offline (SMT=off),
the new kernel is not able to start them and displays some
"Processor X is stuck.".

Starting with POWER8, subcore logic relies on all threads of
core being booted. So, on startup kernel tries to start all
threads, and asks OPAL (or RTAS) to start all CPUs (including
threads). If a CPU has been offlined by the previous kernel,
it has not been returned to OPAL, and thus OPAL cannot restart
it: this CPU has been lost...

Signed-off-by: Laurent Vivier<a class="moz-txt-link-rfc2396E" href="mailto:lvivier@redhat.com">&lt;lvivier@redhat.com&gt;</a>
</pre>
          </blockquote>
          <pre wrap="">

Hi Laurent,
</pre>
        </blockquote>
        <pre wrap="">
Hi Hari,

</pre>
        <blockquote type="cite">
          <pre wrap="">Sorry for jumping too late into this.
</pre>
        </blockquote>
        <pre wrap="">
better late than never :)

</pre>
        <blockquote type="cite">
          <pre wrap="">Are you seeing this issue even with the below patches:

pseries:
<a class="moz-txt-link-freetext" href="http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c1caae3de46a072d0855729aed6e793e536a4a55">http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c1caae3de46a072d0855729aed6e793e536a4a55</a>
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
Unfortunately, this is unlikely to be relevant - this fixes a failure
while setting up the kexec.  The problem we see occurs once we've
booted the second kernel and it's attempting to bring up secondary CPUs.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">opal/powernv:
<a class="moz-txt-link-freetext" href="https://github.com/open-power/skiboot/commit/9ee56b5">https://github.com/open-power/skiboot/commit/9ee56b5</a>
</pre>
        </blockquote>
        <pre wrap="">
Very interesting. Is there a way to have a firmware with the fix ?
</pre>
      </blockquote>
      <pre wrap="">
>From Laurent's analysis of the crash, I don't think this will be</pre>
    </blockquote>
    <br>
    <br>
    <blockquote cite="mid:20151105123243.47dda843@voom.fritz.box"
      type="cite">
      <pre wrap="">
relevant either, but I'm not sure.  It would be very interesting to
know which (if any) released firmwares include this patch so we can
test it.
</pre>
    </blockquote>
    <br>
    Hi Laurent/David,<br>
    <br>
    I am not so sure on this. While I get back on this, can you confirm
    you are<br>
    seeing the issue in both PowerVM (pseries) and baremetal (powernv).
    What is<br>
    the kernel version where the issue is seen for PowerVM and/or
    baremetal.<br>
    Also, for baremetal, can you mention the OPAL version on which the
    issue is<br>
    reproducible. If a bug is raised for this, I would be happy to be
    pointed to,<br>
    to get more information on this.<br>
    <br>
    Thanks<br>
    Hari<br>
    <br>
    <blockquote cite="mid:20151105123243.47dda843@voom.fritz.box"
      type="cite">
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090000000709080102090808--
