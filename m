Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D271C1A00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 16:01:52 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 10:31:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id DE4C43940048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 10:31:45 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB252Mpr66650116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 10:32:22 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB251imf030977
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 10:31:45 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request with
 NO HPTE fault
In-Reply-To: <1417489766.27448.0.camel@kernel.crashing.org>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1417489766.27448.0.camel@kernel.crashing.org>
Date: Tue, 02 Dec 2014 10:31:44 +0530
Message-ID: <87sigyhcg7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2014-11-03 at 20:21 +0530, Aneesh Kumar K.V wrote:
>> upatepp get called for a nohpte fault, when we find from the linux
>> page table that the translation was hashed before. In that case
>> we are sure that there is no existing translation, hence we could
>> avoid doing tlbie.
>
> You need to test your own stuff together :-)
>
> /home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c: In function '__hash_page_thp':
> /home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c:98:17: error: 'local' undeclared (first use in this function)
> /home/benh/linux-powerpc-test/arch/powerpc/mm/hugepage-hash64.c:98:17: note: each undeclared identifier is reported only once for each function it appears in
>

I will redo that patch. I was not sure which of these patches get pulled
in which sequences. So all of that was done on top of master. Hence the
conflict. What i will do is I will respin this on top of what you pushed
to next and send only this patch again.


Thanks
-aneesh
