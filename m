Return-Path: <linuxppcleo@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 7A36667BE5
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 00:54:48 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 50so301000wri
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 07:54:47 -0700 (PDT)
Message-ID: <a0bc9bf80609290754s1ba72951m9825980b05025bef@mail.gmail.com>
Date: Fri, 29 Sep 2006 22:54:46 +0800
From: "Li Yang" <LeoLi@freescale.com>
Sender: linuxppcleo@gmail.com
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/9] Add support for QE and 8360EMDS board -v3
In-Reply-To: <65774A0C-1AD2-4E72-9D89-ACC77BE9CEB4@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <451CF6C0.7040701@freescale.com>
	<65774A0C-1AD2-4E72-9D89-ACC77BE9CEB4@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/29/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>
> On Sep 29, 2006, at 5:34 AM, Li Yang wrote:
>
> > Paul,
> >
> > The series of patches add generic QE infrastructure called
> > qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> > QE device drivers such as ucc_geth driver.
> >
> > This version updates QE interrupt controller to use new irq
> > mapping mechanism, addresses all the comments received with
> > last submission and includes some style fixes.
> >
> > v2: Change to use device tree for BCSR and MURAM;
> > Remove I/O port interrupt handling code as it is not generic
> > enough.
> >
> > v3: Address comments from Kumar;  Update definition of several
> > device tree nodes;  Copyright style change.
>
> In going through this code some general comments:
> * remove typedef's, its not the normal convention to use typedefs the
> way this code is.  Makes it more difficult to read
> * look at use of uint vs u32.  I think there are a number of cases
> were you really want u32.
>
> Also, can you provide some high level description of what all this
> code is doing.  I understand the port io init, I get the interrupt
> handling.  I'm at a loss as that what all the channel ucc_fast/
> ucc_slow code is trying to do and some of the init code.

Well, in brief.  There are many flexible options for QE SoC UCC.  Such
as clock routing, pin multiplexing, virtual fifo, BD rings, etc.   The
ucc code provides generic initialization and configuration routines
for these common options to be reused through drivers.  The
encapsulation of register manipulating code also makes the code more
readable.

- Leo
