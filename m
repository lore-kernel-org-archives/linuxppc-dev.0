Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B3D82DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Nov 2007 19:58:39 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 16 Nov 2007 09:58:37 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
Message-ID: <20071116085837.6650@gmx.net>
MIME-Version: 1.0
References: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73FC8@corpexc01.corp.networkrobots.com>
Subject: Re: hangs after "Freeing unused kernel memory"
To: "Siva Prasad" <sprasad@bivio.net>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 15 Nov 2007 16:00:09 -0800
> Von: "Siva Prasad" <sprasad@bivio.net>
> An: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
> Betreff: hangs after "Freeing unused kernel memory"

> Hi,
> 
> This sounds like a familiar problem, but could not get answers in posts
> that came up in google search.
Yes, this is a familiar problem, at least for me. :-)

> My system hangs after printing the message "Freeing unused kernel
> memory". It should execute init after that, but not sure what exactly is
> happening. Appreciate if some one can throw few ideas to try out.
> 
> Seems it is actually hanging when it makes the call "
> run_init_process(ramdisk_execute_command)" in init/main.c
On my machine it hangs after returning from kernel_execve()/do_execve(),
which is called by run_init_process("/sbin/init"). So the problem can be
almost anywhere. The problem appeared first on kernel 2.6.17. 2.6.16
worked fine on my machine.
I'm going to try out git-bisect on these two kernel revisions, now that I
figured out what people mean when they talk about bisecting. :-) I just
have to figure out how to merge my patches with every branch that is
checked out by git-bisect.

Gerhard

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
