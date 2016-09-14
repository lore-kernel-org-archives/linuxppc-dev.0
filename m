Return-Path: <santhog4@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYykZ12PKzDsW5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:40:53 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8EAbsDv013751
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 06:40:50 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25excd28qe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 06:40:50 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <santhog4@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 20:40:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C04A32BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:40:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8EAejPb52297840
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:40:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8EAejte000768
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 20:40:45 +1000
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
From: santhosh <santhog4@linux.vnet.ibm.com>
Cc: manvanth@linux.vnet.ibm.com
Date: Wed, 14 Sep 2016 16:10:43 +0530
MIME-Version: 1.0
In-Reply-To: <87y4893ar2.fsf@skywalker.in.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------7CE09EFBA896CDD3EF8FDE17"
Message-Id: <0d167ff1-cc0e-35bc-479c-aec77d2c8556@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------7CE09EFBA896CDD3EF8FDE17
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


> Michael Ellerman <mpe@ellerman.id.au> writes:
>
>> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>>
>> ...
>>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>>> and from 13-64 to 9-13 for 4K pages.
>>>
>>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>>> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>>
> HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
> size. We do have the below constraint w.r.t hugetlb pages
>
> static inline bool hstate_is_gigantic(struct hstate *h)
> {
> 	return huge_page_order(h) >= MAX_ORDER;
> }
>
> That require MAX_ORDER to be greater than 12.
>
> Did we test hugetlbfs 4k config with this patch ? Will it work if we
> start marking hugepage as gigantic page ?
>
> -aneesh
>
Hello Rashmica,

With upstream linux kernel 4.8.0-rc1-00006-gbae9cc6 compiled with linux 
4k page size we are not able set hugepages, Aneesh had a look at the 
problem and he mentioned this commit is causing the issue.

*Details:*
We are using pkvm ubuntu 16.04 guest with upstream kernel 
[4.8.0-rc1-00006-gbae9cc6] compiled with  4k page size

o/p from guest:
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:      16384 kB

Page sizes from device-tree: [dmesg]
[    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, 
tlbiel=1, penc=0
[    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, 
tlbiel=1, penc=56
[    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, 
tlbiel=0, penc=0

while trying to configure the hugepages inside the guest it throws the 
below error:

echo 100 > /proc/sys/vm/nr_hugepages
-bash: echo: write error: Invalid argument

*Note*: we do not see the problem when the linux page is 64k

Thanks,
Santhosh G


--------------7CE09EFBA896CDD3EF8FDE17
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <blockquote cite="mid:87y4893ar2.fsf@skywalker.in.ibm.com"
      type="cite">
      <pre wrap="">Michael Ellerman <a class="moz-txt-link-rfc2396E" href="mailto:mpe@ellerman.id.au">&lt;mpe@ellerman.id.au&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="">On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.

</pre>
        </blockquote>
        <pre wrap="">...
</pre>
        <blockquote type="cite">
          <pre wrap="">So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
and from 13-64 to 9-13 for 4K pages.

Signed-off-by: Rashmica Gupta <a class="moz-txt-link-rfc2396E" href="mailto:rashmicy@gmail.com">&lt;rashmicy@gmail.com&gt;</a>
Reviewed-by: Balbir Singh <a class="moz-txt-link-rfc2396E" href="mailto:bsingharora@gmail.com">&lt;bsingharora@gmail.com&gt;</a>
</pre>
        </blockquote>
        <pre wrap="">
Applied to powerpc next, thanks.

<a class="moz-txt-link-freetext" href="https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea">https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea</a>

</pre>
      </blockquote>
      <pre wrap="">
HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
size. We do have the below constraint w.r.t hugetlb pages

static inline bool hstate_is_gigantic(struct hstate *h)
{
	return huge_page_order(h) &gt;= MAX_ORDER;
}

That require MAX_ORDER to be greater than 12.

Did we test hugetlbfs 4k config with this patch ? Will it work if we
start marking hugepage as gigantic page ?

-aneesh

</pre>
    </blockquote>
    Hello Rashmica,<br>
    <br>
    With upstream linux kernel 4.8.0-rc1-00006-gbae9cc6 compiled with
    linux 4k page size we are not able set hugepages, Aneesh had a look
    at the problem and he mentioned this commit is causing the issue.<br>
    <br>
    <b>Details:</b><br>
    We are using pkvm ubuntu 16.04 guest with upstream kernel
    [4.8.0-rc1-00006-gbae9cc6] compiled with  4k page size<br>
    <br>
    o/p from guest:<br>
    HugePages_Total:       0<br>
    HugePages_Free:        0<br>
    HugePages_Rsvd:        0<br>
    HugePages_Surp:        0<br>
    Hugepagesize:      16384 kB<br>
    <br>
    Page sizes from device-tree: [dmesg]<br>
    [    0.000000] base_shift=12: shift=12, sllp=0x0000,
    avpnm=0x00000000, tlbiel=1, penc=0<br>
    [    0.000000] base_shift=12: shift=24, sllp=0x0000,
    avpnm=0x00000000, tlbiel=1, penc=56<br>
    [    0.000000] base_shift=24: shift=24, sllp=0x0100,
    avpnm=0x00000001, tlbiel=0, penc=0<br>
    <br>
    while trying to configure the hugepages inside the guest it throws
    the below error:<br>
     <br>
    echo 100 &gt; /proc/sys/vm/nr_hugepages<br>
    -bash: echo: write error: Invalid argument<br>
    <br>
    <b>Note</b>: we do not see the problem when the linux page is 64k<br>
    <br>
    Thanks,<br>
    Santhosh G<br>
    <br>
  </body>
</html>

--------------7CE09EFBA896CDD3EF8FDE17--
