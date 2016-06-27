Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdZPD1VmnzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 02:38:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RGTkGp025438
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:38:06 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sm9dxttv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:38:06 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 13:38:03 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id F07AA3520068
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 12:37:43 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RGc0kh4788430
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 13:38:00 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RGc0C5000997
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 13:38:00 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 3/9] kexec_file: Factor out kexec_locate_mem_hole from
 kexec_add_buffer.
Date: Mon, 27 Jun 2016 13:37:58 -0300
In-Reply-To: <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
References: <1466538521-31216-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4923900.bfxGnX6mM2@hactar>
 <20160627161948.GA5876@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <5428891.iJNV8CI1We@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Dienstag, 28 Juni 2016, 00:19:48 schrieb Dave Young:
> On 06/23/16 at 12:37pm, Thiago Jung Bauermann wrote:
> > Am Donnerstag, 23 Juni 2016, 01:44:07 schrieb Dave Young:
> > What is bad about the description of top_down?
> It is not clear enough to me, I personally think the original one in
> source code is better:
> /* allocate from top of memory hole */

Actually I realized there's some discrepancy in how the x86 code uses 
top_down and how I need it to work in powerpc. This may be what is confusing 
about my comment and the existing comment.

x86 always walks memory from bottom to top but if top_down is true, in each 
memory region it will allocate the memory hole in the highest address within 
that region. I don't know why it is done that way, though.

On powerpc, the memory walk itself should be from top to bottom, as well as 
the memory hole allocation within each memory region.

Should I add a separate top_down argument to kexec_locate_mem_hole to 
control if the memory walk should be from top to bottom, and then the 
bottom_up member of struct kexec_buf controls where inside each memory 
region the memory hole will be allocated?

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
