Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP3YB08h5zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:47:25 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G4ivkf062551
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:47:23 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28mq9kt59u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 23:47:23 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 16 Feb 2017 14:47:20 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 60D2D2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:47:17 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1G4l9Vr39059580
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:47:17 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1G4kirN010431
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 15:46:45 +1100
Subject: Re: [PATCH 1/3] pci/hotplug/pnv-php: Remove WARN_ON() in
 pnv_php_put_slot()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1487200954-14681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 "# v4 . 8+" <stable@vger.kernel.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 16 Feb 2017 15:46:20 +1100
MIME-Version: 1.0
In-Reply-To: <1487200954-14681-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6c4942ee-7704-5686-8bf3-3cff775eff89@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/17 10:22, Gavin Shan wrote:
> The WARN_ON() causes unnecessary backtrace when putting the parent
> slot, which is likely to be NULL.
>
>  WARNING: CPU: 2 PID: 1071 at drivers/pci/hotplug/pnv_php.c:85 \
>                               pnv_php_release+0xcc/0x150 [pnv_php]
>     :
>  Call Trace:
>  [c0000003bc007c10] [d00000000ad613c4] pnv_php_release+0x144/0x150 [pnv_php]
>  [c0000003bc007c40] [c0000000006641d8] pci_hp_deregister+0x238/0x330
>  [c0000003bc007cd0] [d00000000ad61440] pnv_php_unregister_one+0x70/0xa0 [pnv_php]
>  [c0000003bc007d10] [d00000000ad614c0] pnv_php_unregister+0x50/0x80 [pnv_php]
>  [c0000003bc007d40] [d00000000ad61e84] pnv_php_exit+0x50/0xcb4 [pnv_php]
>  [c0000003bc007d70] [c00000000019499c] SyS_delete_module+0x1fc/0x2a0
>  [c0000003bc007e30] [c00000000000b184] system_call+0x38/0xe0
>
> Cc: <stable@vger.kernel.org> # v4.8+
> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
