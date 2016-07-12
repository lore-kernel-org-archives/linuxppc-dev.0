Return-Path: <ptesarik@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpwh96HGFzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 07:53:29 +1000 (AEST)
Date: Tue, 12 Jul 2016 23:53:25 +0200
From: Petr Tesarik <ptesarik@suse.cz>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: bhe@redhat.com, arnd@arndb.de, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro
 <takahiro.akashi@linaro.org>, vgoyal@redhat.com, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 0/3] extend kexec_file_load system call
Message-ID: <20160712235325.48cc0fee@hananiah.suse.cz>
In-Reply-To: <87a8hm1ri8.fsf@x220.int.ebiederm.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <87a8hm1ri8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jul 2016 16:22:07 -0500
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Petr Tesarik <ptesarik@suse.cz> writes:
> 
> > On Tue, 12 Jul 2016 13:25:11 -0300
> > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
>[...]
> >> I also don't understand what you mean by code execution. How does passing a 
> >> device tree blob via kexec enables code execution? How can the signature 
> >> scheme be defeated?
> >
> > I'm not an expert on DTB, so I can't provide an example of code
> > execution, but you have already mentioned the /chosen/linux,stdout-path
> > property. If an attacker redirects the bootloader to an insecure
> > console, they may get access to the system that would otherwise be
> > impossible.
> >
> > In general, tampering with the hardware inventory of a machine opens up
> > a security hole, and one must be very cautious which modifications are
> > allowed. You're giving this power to an (unsigned, hence untrusted)
> > userspace application; Eric argues that only the kernel should have
> > this power.
> 
> At the very least it should be signed.  And of course the more signed
> images we have in different combinations the more easily someone can
> find a combination that does things the people performing the signing
> didn't realizing they were allowing.

Exactly. Reminds me of nasty setuid application exploits when one or
more of stdin, stdout and stderr are closed before exec(), so the first
file to be opened gets one of those special file descriptors. Imagine
what happens if the application opens a secret file for reading (now
file descriptor 0), then expects user input on stdin, detects a syntax
error and complains on stderr, including the full input for reference
("%s is not a valid command")...

No one has designed bootloaders to cope with similar unexpected
situations.

> So if we can not add an extra variable into the mix it would be good.

Indeed. Writing boot loaders is difficult enough already. Adding the
same kind of precautions that are necessary to write secure setuid
applications is over the top IMO.

Petr T
