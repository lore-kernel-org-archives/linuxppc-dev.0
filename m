Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rXCnc0skVzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jun 2016 09:22:11 +1000 (AEST)
Message-ID: <1466292111.24271.89.camel@kernel.crashing.org>
Subject: Re: [PATCH V2] powerpc/mm: Don't do debug print before we do
 feature fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>
Date: Sun, 19 Jun 2016 09:21:51 +1000
In-Reply-To: <1466274479-5650-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1466274479-5650-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-06-18 at 23:57 +0530, Aneesh Kumar K.V wrote:
> We use feature fixup in segment and page fault path and hence we should
> not call any function that can cause either of these before we finish
> feature fixup.
> 
> Calling into early debug routine can result in segment fault as updated
> in https://lkml.kernel.org/r/CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com
> 
> Avoid the segment fault by removing the debug print. Also remove the
> matching closing debug print at the end of the function.

Please add a comment at the beginning of setup_system() explaining
the situation. IE, that until the fixups are done, not even debug
printfs can be used.

It used to work though, the fact that we used 256M segment in that
case wasn't an issue, in part because btext only really existed on
machines that didn't have 1T segments. It was only ever going to be
a segment fault, the rest was bolted (early ioremap).

Ben.
