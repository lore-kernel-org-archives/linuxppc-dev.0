Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwZxJ5x7JzDrFr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 12:54:28 +1000 (AEST)
From: Michael Ellerman <michael@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Vivek Goyal <vgoyal@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>, Dave Young <dyoung@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <4197460.etrDupniY8@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <3489461.zQnV5C1bXR@wuerfel> <1808359.GMbkTHC4O6@hactar>
 <4197460.etrDupniY8@hactar>
Date: Fri, 22 Jul 2016 12:54:28 +1000
Message-ID: <878twutmaj.fsf@concordia.ellerman.id.au>
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

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Freitag, 15 Juli 2016, 18:03:35 schrieb Thiago Jung Bauermann:
>> Am Freitag, 15 Juli 2016, 22:26:09 schrieb Arnd Bergmann:
>> > However, the powerpc specific RTAS runtime services provide a similar
>> > interface to the UEFI runtime support and allow to call into
>> > binary code from the kernel, which gets mapped from a physical
>> > address in the "linux,rtas-base" property in the rtas device node.
>> > 
>> > Modifying the /rtas node will definitely give you a backdoor into
>> > priviledged code, but modifying only /chosen should not let you get
>> > in through that specific method.
>> 
>> Except that arch/powerpc/kernel/rtas.c looks for any node in the tree
>> called "rtas", so it will try to use /chosen/rtas, or /chosen/foo/rtas.
>> 
>> We can forbid subnodes in /chosen in the dtb passed to kexec_file_load,
>> though that means userspace can't use the simple-framebuffer binding via
>> this mechanism.
>> 
>> We also have to blacklist the device_type and compatible properties in
>> /chosen to avoid the problem Mark mentioned.
>> 
>> Still doable, but not ideal. :-/
>
> So even if not ideal, the solution above is desirable for powerpc. We would 
> like to preserve the ability of allowing userspace to pass parameters to the 
> OS via the DTB, even if secure boot is enabled.
>
> I would like to turn the above into a proposal:
>
> Extend the syscall as shown in this RFC from Takahiro AKASHI, but instead of 
> accepting a complete DTB from userspace, the syscall accepts a DTB 
> containing only a /chosen node. If the DTB contains any other node, the 
> syscall fails with EINVAL. If the DTB contains any subnode in /chosen, or if 
> there's a compatible or device_type property in /chosen, the syscall fails 
> with EINVAL as well.
>
> The kernel can then add the properties in /chosen to the device tree that it 
> will pass to the next kernel.
>
> What do you think?

I think we will inevitably have someone who wants to pass something
other than a child of /chosen.

At that point we would be faced with adding yet another syscall, or at
best a new flag.

I think we'd be better allowing userspace to pass a DTB, and having an
explicit whitelist (in the kernel) of which nodes & properties are
allowed in that DTB.

For starters it would only contain /chosen/stdout-path (for example).
But we would be able to add new nodes & properties in future.

The downside is userspace would have no way of detecting the content of
the white list, other than trial and error. But in practice I'm not sure
that would be a big problem.

cheers
