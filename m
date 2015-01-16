Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 669231A0DD0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 21:20:01 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 16 Jan 2015 10:19:57 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0FB991B08069
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 10:19:55 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0GAJtqD60424374
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 10:19:55 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0GAJtb0019853
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 05:19:55 -0500
Message-ID: <54B8E5C9.5090006@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 11:19:53 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] pseries/le: Fix another endiannes issue in RTAS call
 from xmon
References: <1421295950.11409.3.camel@ellerman.id.au>
 <1421342627-7214-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <54B8188D.1060907@linux.vnet.ibm.com>
 <1421360377.23332.1.camel@ellerman.id.au>
 <54B85016.4080906@linux.vnet.ibm.com>
 <1421377361.18166.2.camel@ellerman.id.au>
In-Reply-To: <1421377361.18166.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/01/2015 04:02, Michael Ellerman wrote:
> On Thu, 2015-01-15 at 15:41 -0800, Tyrel Datwyler wrote:
>> On 01/15/2015 02:19 PM, Michael Ellerman wrote:
>> If this was on a powerkvm guest set-indicator should be present for
>> hotplug (DLPAR) support. However, the surveillance indicator would not
>> be implemented. I know sometimes I forget if I'm on a powervm or
>> powerkvm guest. Just a thought.
> 
> Right that does explain it. I went looking for the KVM kernel/qemu code that
> implements set-indicator but couldn't find it. Presumably it's in some branch
> other than the one I was looking at, or I was grepping for the wrong thing.
> 
> So I guess a printf there is probably not helpful, because it will fire always
> on PowerKVM (at least at the moment).

FWIW, the PAPR mentions that the surveillance indicator may not be
implemented. In that case -3 is returned.? I double checked that on my LPAR.

One option would be to warn only if the returned value is different from
0 and -3.

Cheers
