Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C2FW5113zF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 01:15:39 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5MFEl0O090918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 11:15:37 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2js299kx9y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 11:15:36 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 22 Jun 2018 09:15:36 -0600
Subject: Re: [PATCH] selftests/powerpc: Fix strncpy usage
To: Breno Leitao <leitao@debian.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1529535071-14555-1-git-send-email-leitao@debian.org>
 <20180621231856.GO16221@gate.crashing.org>
 <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 22 Jun 2018 10:15:29 -0500
MIME-Version: 1.0
In-Reply-To: <1dc025d5-366c-ae13-259e-dae543e6ec52@debian.org>
Message-Id: <12953a47-a6a7-5f70-a46c-c95f8c424d11@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/22/2018 09:43 AM, Breno Leitao wrote:
> If you don't mind, I would solve this problem slightly different, as it seems
> to be more readable.
> 
> -       strncpy(prog, argv[0], strlen(argv[0]));
> +       if (strlen(argv[0]) >= LEN_MAX){
> +               fprintf(stderr, "Very big executable name: %s\n", argv[0]);

"Very big" is an observation.  "Too big" indicates a problem better.  Or, more explicitly "Executable name is too long".

PC
