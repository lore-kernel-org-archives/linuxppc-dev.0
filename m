Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrkdt5htnzDr0V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 06:27:45 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Vivek Goyal <vgoyal@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Date: Fri, 15 Jul 2016 22:26:09 +0200
Message-ID: <3489461.zQnV5C1bXR@wuerfel>
In-Reply-To: <20160715134209.GF1041@n2100.armlinux.org.uk>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160715132610.GD23514@redhat.com>
 <20160715134209.GF1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, July 15, 2016 2:42:10 PM CEST Russell King - ARM Linux wrote:
> 
> On other architectures, DT can also contain open-firmware "functions"
> but I don't think there's much support in the kernel for that - maybe
> the PPC folk can reply on that point.

The open firmware runtime interface are shut down by the time we have
a flattened device tree, so those are not accessible any more. IIRC
SPARC leaves the open firmware interface live, but it doesn't use
fdt, so that's not relevant here.

However, the powerpc specific RTAS runtime services provide a similar
interface to the UEFI runtime support and allow to call into
binary code from the kernel, which gets mapped from a physical
address in the "linux,rtas-base" property in the rtas device node.

Modifying the /rtas node will definitely give you a backdoor into
priviledged code, but modifying only /chosen should not let you get
in through that specific method.

	Arnd
