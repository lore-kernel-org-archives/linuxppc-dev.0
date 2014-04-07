Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 957B21400C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 17:42:36 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Apr 2014 13:12:33 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5F0833940023
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 13:12:30 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s377gQ1Z917808
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Apr 2014 13:12:26 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s377gT1H028029
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Apr 2014 13:12:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.com>, Liu ping fan <kernelfans@gmail.com>,
 Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
In-Reply-To: <533D47CD.906@suse.com>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
 <CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>
 <533D47CD.906@suse.com>
Date: Mon, 07 Apr 2014 13:12:29 +0530
Message-ID: <87bnwdshzu.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.com> writes:

> On 03.04.14 04:36, Liu ping fan wrote:
>> Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
>> enable numa fault for powerpc.
>
> What bad happens without this patch? We map a page even though it was 
> declared to get NUMA migrated? What happens next?

Nothing much, we won't be properly accounting the numa access in the
host.  What we want to achieve is to convert a guest access of the page to
a host fault so that we can do proper numa access accounting in the
host. This would enable us to migrate the page to the correct numa
node. 

>
> I'm trying to figure out whether I need to mark this with a stable tag 
> for 3.14.
>
>

-aneesh
