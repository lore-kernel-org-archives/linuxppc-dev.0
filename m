Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdcjg3jSyzDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 04:22:29 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RIJSpC066307
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 14:22:26 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23sp507ath-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 14:22:26 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 15:22:24 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 4CD471DC0074
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 14:22:14 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5RIMLQ035848236
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 15:22:21 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5RIML11020798
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 15:22:21 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Geoff Levand <geoff@infradead.org>,
 James Morse <james.morseatarm.com@hactar>, kexec@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v20 14/14] Documentation: dt: usable-memory and elfcorehdr
 nodes for arm64 kexec
Date: Mon, 27 Jun 2016 15:22:18 -0300
In-Reply-To: <e212cd53fdf9d09923408eb906fe0228d22432a9.1466702804.git.geoff@infradead.org>
References: <cover.1466702804.git.geoff@infradead.org>
 <e212cd53fdf9d09923408eb906fe0228d22432a9.1466702804.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <9127562.8x2DzY0I6N@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Am Donnerstag, 23 Juni 2016, 17:54:49 schrieb Geoff Levand:
> +linux,usable-memory
> +-------------------
> +
> +This property is set on PowerPC and arm64 by kexec-tools during kdump
> +to tell the crash kernel the base address of its reserved area of memory,
> and +the size. e.g.
> +
> +/ {
> +	chosen {
> +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> +	};
> +};

On powerpc, linux,usable-memory isn't in /chosen. It is put by kexec-tools 
in each /memory node and has the same format as the reg property. During 
early boot, the kernel goes through the /memory nodes to find usable memory 
and for each node, if there's a linux,usable-memory property it will use it 
instead of the reg property to find the ranges of memory it can use (see 
early_init_dt_scan_memory in drivers/of/fdt.c).

[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
