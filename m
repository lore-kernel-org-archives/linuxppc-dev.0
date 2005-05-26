Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 9C016679E7
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 22:36:30 +1000 (EST)
To: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 26 May 2005 12:09:51 +0200."
	<D4FDDD1349B5AC46B68FC26AD8AF42D6226B2C@exnet.3il.fr>
Date: Thu, 26 May 2005 14:35:58 +0200
Sender: wd@denx.de
Message-Id: <20050526123603.2421EC1512@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to register a user-space function as an interrupt handler ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

in message <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2C@exnet.3il.fr> you wrote:
> Hi everybody, I'm tryin to adapt a vxWorks-designed application to a
...
> What I would like to do is to make an emulation of both vxWorks routines
> (intConnect() and intEnable()) in the linux world
> cause I'm not allowed to change that code.

This makes no sense. You cannot "port"  such  code  from  VxWorks  to
Linux without making any changes.

As for your question: in Linux interrupt hadling  happens  in  kernel
context  only.  You cannot register user space functions as interrupt
handlers.

> Furthermore, I'm a newbie in linux developpment and if I understand
> well, I need to be in kernel-space to call those routines. 

Right.

> But here is my problem: the interrupt handler that we call is part of
> the application and uses a lot of #define,semaphores and other 
> ressources of the user-application. So can I implement a new linux
> system call, that will register our user-space-function (my_handler())

This cannot and should not be done. You will have to go through  your
software   design   and   adapt  it  for  the  new  operating  system
environment. Unix has somewhat different concepts how some things get
done, and instead of fighting with this envrionment you should  adapt
to it.

> Don't forget that I have to respect two conditions: my application must
> be run from user-space and I cannot modify the 
> code (my team does not want to support versions).

Simple answer: The job cannot be done under such constraints.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"It is better to have tried and failed than to have  failed  to  try,
but the result's the same."                           - Mike Dennison
