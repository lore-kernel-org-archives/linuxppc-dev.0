Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjWfm23x7zF1MY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 22:50:24 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1GBncTv011666
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 06:50:21 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5s1vvx1b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 06:50:21 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 16 Feb 2018 04:50:20 -0700
Subject: Re: [PATCH 2/3] rfi-flush: Make it possible to call setup_rfi_flush()
 again
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
 <1518644021-17037-3-git-send-email-mauricfo@linux.vnet.ibm.com>
 <20180215081358.2f37cda4@naga.suse.cz>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 09:50:13 -0200
MIME-Version: 1.0
In-Reply-To: <20180215081358.2f37cda4@naga.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b87d6261-c48d-6eab-e328-6988f628c949@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal and Michael,

On 02/15/2018 05:13 AM, Michal Suchánek wrote:
>> From: Michael Ellerman<mpe@ellerman.id.au>
>>
>> For PowerVM migration we want to be able to call setup_rfi_flush()
>> again after we've migrated the partition.
>>
>> To support that we need to check that we're not trying to allocate the
>> fallback flush area after memblock has gone away. If so we just fail,
>> we don't support migrating from a patched to an unpatched machine. Or
>> we do support it, but there will be no RFI flush enabled on the
>> destination.
>>
> This sounds bad to me. Either we support RFI flush or we don't.
> 
> If we do the fallback area should be allocated at boot so it is always
> available. [snip]

I think the problem with this is the size of the fallback area might
have to be different between the origin and destination systems, say,
a larger L1 data cache at the destination.

In that case, the original size might not be enough to fully flush
the L1 data cache.

Michael, is that the reason it is done that way?  I thought of that,
but don't know for sure.

Thanks!
Mauricio
