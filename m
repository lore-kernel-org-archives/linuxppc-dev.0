Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQFn4dmXzDrRm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:49:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Harshal Patil <harshal.patil@in.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sudipto Ghosh <sudiptoghosh@in.ibm.com>
Subject: Re: ioctl structs differ from x86_64?
In-Reply-To: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
References: <OF8A8205F0.34AB5FF3-ON002580E3.00393B30-002580E3.003A62F5@notes.na.collabserv.com>
Date: Thu, 16 Mar 2017 21:49:12 +1100
Message-ID: <87var9jy3b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Harshal Patil <harshal.patil@in.ibm.com> writes:

> Hello,
> I am looking into a bug, https://bugzilla.linux.ibm.com/show_bug.cgi?id=152493
> ( external mirror is at, https://github.com/opencontainers/runc/issues/1364) 
> Recently in runc code, they added this code
> https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR155.
> As you can see they set -onlcr to get rid of \r (line no. 164). Golang, in which
> runc is written, doesn't have any bindings for ioctls. This means you have to
> invoke C code directly (that's what they are doing there).
> Our guess is the ioctls in ppc64le differ than x86_64, and thats why the code
> which is clearing onclr bit
> (https://github.com/opencontainers/runc/commit/eea28f480db435dbef4a275de9776b9934818b8c#diff-5f5c07d0cab3ce2086437d3d43c0d25fR164)
> is failing on ppc64le but works fine on x86_64. 

I think you've probably got enough replies, but the short answer is
"yes", IOCTL numbers do differ across architectures - including
potentially between 32-bit and 64-bit.

cheers
