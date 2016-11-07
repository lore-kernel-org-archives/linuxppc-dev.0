Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBtZg53zdzDvNL
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 11:28:11 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA70NrDt068890
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 19:28:09 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jb2h77ux-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 19:28:09 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 7 Nov 2016 10:28:06 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 495002CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 11:28:05 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA70S5cN5767340
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 11:28:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA70S4Vn004664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 11:28:05 +1100
Subject: Re: [RESEND] [PATCH v3] cxl: Prevent adapter reset if an active
 context exists
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <1476437916-31010-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <544d8d01-162a-9634-258d-05e6314bddcc@au1.ibm.com>
 <f95e641e-3ceb-5f28-ea45-95fce2d9d2e1@linux.vnet.ibm.com>
 <d318986b-6495-25f0-193d-aef046af6938@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com, Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 7 Nov 2016 11:28:03 +1100
MIME-Version: 1.0
In-Reply-To: <d318986b-6495-25f0-193d-aef046af6938@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <33fa0c09-d58c-27a2-aa14-4a87bdb750d6@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/16 00:15, Uma Krishnan wrote:
> Frederic/Andrew,
>
> Just recently this issue has been reported by system test without any
> of the two patches you are suspecting - this patch nor the lspci patch.
> I was hoping the lspci patch from Andrew can possibly solve it.
> System test CQ is SW370625. The stack reported in that is same,
>
> [ 5895.245959] EEH: PHB#2 failure detected, location: N/A
> [ 5895.246078] CPU: 19 PID: 121774 Comm: lspci Not tainted
> 3.10.0-514.el7.ppc64le #1
> [ 5895.246240] Call Trace:
> [ 5895.246307] [c0000009f3707a60] [c000000000017ce0]
> show_stack+0x80/0x330 (unreliable)
> [ 5895.246501] [c0000009f3707b10] [c0000000009b22f4]
> dump_stack+0x30/0x44
> [ 5895.246665] [c0000009f3707b30] [c00000000003b9ac]
> eeh_dev_check_failure+0x21c/0x580
> [ 5895.246855] [c0000009f3707bd0] [c0000000000879dc]
> pnv_pci_read_config+0xbc/0x160
> [ 5895.247045] [c0000009f3707c10] [c000000000527d54]
> pci_user_read_config_dword+0x84/0x160
> [ 5895.247233] [c0000009f3707c60] [c000000000547224]
> pci_read_config+0xf4/0x2e0
> [ 5895.247398] [c0000009f3707ce0] [c0000000003efb3c] read+0x10c/0x2a0
> [ 5895.247561] [c0000009f3707da0] [c00000000031d160]
> vfs_read+0x110/0x290
> [ 5895.247726] [c0000009f3707de0] [c00000000031ec70]
> SyS_pread64+0xb0/0xd0

This isn't a WARN - this stack trace is printed explicitly by the EEH 
code in the case of a PHB failure. arch/powerpc/kernel/eeh.c, line 403.


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
