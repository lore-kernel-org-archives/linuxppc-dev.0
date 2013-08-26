Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-qa0-x230.google.com (mail-qa0-x230.google.com
 [IPv6:2607:f8b0:400d:c00::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D75E2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 17:39:26 +1000 (EST)
Received: by mail-qa0-f48.google.com with SMTP id hu14so135981qab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 00:39:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <521B0622.9090208@redhat.com>
Date: Mon, 26 Aug 2013 09:39:14 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 2/2] ppc: kvm: use anon_inode_getfd() with O_CLOEXEC flag
References: <cover.1377372576.git.ydroneaud@opteya.com>
 <b7ae23be3a3d4a2f57eca6cfc7f9361da883ceca.1377372576.git.ydroneaud@opteya.com>
 <3557EF65-4327-4DAE-999A-B0EE13C433F5@suse.de>
In-Reply-To: <3557EF65-4327-4DAE-999A-B0EE13C433F5@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Yann Droneaud <ydroneaud@opteya.com>, kvm@vger.kernel.org,
 Gleb Natapov <gleb@redhat.com>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 25/08/2013 17:04, Alexander Graf ha scritto:
> 
> On 24.08.2013, at 21:14, Yann Droneaud wrote:
> 
>> KVM uses anon_inode_get() to allocate file descriptors as part
>> of some of its ioctls. But those ioctls are lacking a flag argument
>> allowing userspace to choose options for the newly opened file descriptor.
>>
>> In such case it's advised to use O_CLOEXEC by default so that
>> userspace is allowed to choose, without race, if the file descriptor
>> is going to be inherited across exec().
>>
>> This patch set O_CLOEXEC flag on all file descriptors created
>> with anon_inode_getfd() to not leak file descriptors across exec().
>>
>> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
>> Link: http://lkml.kernel.org/r/cover.1377372576.git.ydroneaud@opteya.com
> 
> Reviewed-by: Alexander Graf <agraf@suse.de>
> 
> Would it make sense to simply inherit the O_CLOEXEC flag from the
> parent kvm fd instead? That would give user space the power to keep
> fds across exec() if it wants to.

Does it make sense to use non-O_CLOEXEC file descriptors with KVM at
all?  Besides fork() not being supported by KVM, as described in
Documentation/virtual/kvm/api.txt, the VMAs of the parent process go
away as soon as you exec().  I'm not sure how you can use the inherited
file descriptor in a sensible way after exec().

Paolo
