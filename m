Return-Path: <wcohen@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBtkR0X9DzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 02:35:11 +1100 (AEDT)
Subject: Re: gcc trunk fails to build kernel on PowerPC64 due to oprofile
 warnings
To: Robert Richter <rric@kernel.org>
References: <20170126100044.7e439f72@kryten>
 <fe2c2fd9-d255-61ca-5328-ca5d45827f47@redhat.com>
 <20170126160512.GE4906@rric.localdomain>
Cc: Michael Ellerman <mpe@ellerman.id.au>, oprofile-list@lists.sf.net,
 Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: William Cohen <wcohen@redhat.com>
Message-ID: <541c2cc7-9ea3-9aeb-a12d-c3d46717a7f7@redhat.com>
Date: Mon, 30 Jan 2017 10:35:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170126160512.GE4906@rric.localdomain>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2017 11:06 AM, Robert Richter wrote:
> On 26.01.17 10:46:43, William Cohen wrote:
>> From 7e46dbd7dc5bc941926a4a63c28ccebf46493e8d Mon Sep 17 00:00:00 2001
>> From: William Cohen <wcohen@redhat.com>
>> Date: Thu, 26 Jan 2017 10:33:59 -0500
>> Subject: [PATCH] Avoid hypthetical string truncation in oprofile stats buffer
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> Increased the size of an internal oprofile driver buffer ensuring that
>> the string was never truncated for any possible int value to avoid the
>> following gcc-7 compiler error on ppc when building the kernel:
> 
> Please test gcc7 for other archs first. I don't think this is the only
> change needed to avoid this warning in oprofile code.
> 
> Thanks,
> 
> -Robert

Hi Robert,

It took me a little while to get a gcc-7 environment set up with Fedora Rawhide on x86_64.  I have a kernel building now with gcc-7 and will see what other issues pop up during the compile.

While watching the output of the build I see the gcc-7 error message about truncating output of snprintf output seems to occur for a number of other places besides the oprofile kernel code during the compile.

-Will
