Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8cGf2vjwzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 23:36:58 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LDYbtZ006893
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:36:55 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29yffj2yd9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 09:36:55 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 21 Apr 2017 07:36:54 -0600
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v4 4/7] powerpc/kprobes: Use safer string functions in
 kprobe_lookup_name()
References: <6e14d22994530fb5200c74d1593e73541d3b8028.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170421123320.7344-1-naveen.n.rao@linux.vnet.ibm.com>
 <5393535f-4469-d6b7-f7ce-256a5612999f@us.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 linux-kernel@vger.kernel.org
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 21 Apr 2017 08:36:48 -0500
MIME-Version: 1.0
In-Reply-To: <5393535f-4469-d6b7-f7ce-256a5612999f@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8b6fb142-3cac-fa8a-406a-9f9b0949de07@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/21/2017 08:33 AM, Paul Clarke wrote:
> On 04/21/2017 07:33 AM, Naveen N. Rao wrote:
>>  	} else if (name[0] != '.') {
>>  		dot_name[0] = '.';
>>  		dot_name[1] = '\0';
>> -		strncat(dot_name, name, KSYM_NAME_LEN - 2);
>> +		strlcat(dot_name, name, sizeof(dot_name));
> 
> and here do:
> strncpy(&dot_name[1], name, sizeof(dot_name));

oops.  s/sizeof(dot_name)/sizeof(dot_name) - 1/

PC
