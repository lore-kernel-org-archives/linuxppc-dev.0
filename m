Return-Path: <asarai@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkdhC1tSVzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 20:24:42 +1000 (AEST)
Subject: Re: [PATCH v4 2/2] tty: add TIOCGPTPEER ioctl
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-arch@vger.kernel.org, Christian Brauner
 <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
References: <20170603141515.9529-1-asarai@suse.de>
 <20170603141515.9529-3-asarai@suse.de> <20170609092659.GA26933@kroah.com>
 <44c2b6c7-63ee-5c7f-cc77-5e1bcd69eea4@suse.de>
 <20170609100442.GA1405@kroah.com>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <f3587aca-0d84-1ca7-cfb0-830e536410c2@suse.de>
Date: Fri, 9 Jun 2017 20:24:30 +1000
MIME-Version: 1.0
In-Reply-To: <20170609100442.GA1405@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> When opening the slave end of a PTY, it is not possible for userspace to
>>>> safely ensure that /dev/pts/$num is actually a slave (in cases where the
>>>> mount namespace in which devpts was mounted is controlled by an
>>>> untrusted process). In addition, there are several unresolvable
>>>> race conditions if userspace were to attempt to detect attacks through
>>>> stat(2) and other similar methods [in addition it is not clear how
>>>> userspace could detect attacks involving FUSE].
>>>>
>>>> Resolve this by providing an interface for userpace to safely open the
>>>> "peer" end of a PTY file descriptor by using the dentry cached by
>>>> devpts. Since it is not possible to have an open master PTY without
>>>> having its slave exposed in /dev/pts this interface is safe. This
>>>> interface currently does not provide a way to get the master pty (since
>>>> it is not clear whether such an interface is safe or even useful).
>>>>
>>>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>>>> Cc: Valentin Rothberg <vrothberg@suse.com>
>>>> Signed-off-by: Aleksa Sarai <asarai@suse.de>
>>>
>>> Is this going to be documented anywhere?  Is there a man page update
>>> that also goes along with this?
>>
>> I will add one, I didn't know where the man-pages project is hosted / where
>> patches get pushed? What is the ML?
> 
>  From the MAINTAINERS file:
>    MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
>    M:      Michael Kerrisk <mtk.manpages@gmail.com>
>    W:      http://www.kernel.org/doc/man-pages
>    L:      linux-man@vger.kernel.org
>    S:      Maintained

Ah, should've looked there first!

Thanks Greg, I'll send it over the weekend.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
