Message-ID: <3C59AEE5.2070900@embeddededge.com>
Date: Thu, 31 Jan 2002 15:53:57 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Boutcher <boutcher@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: why is tty->pgrp set to -1 for console?
References: <OFA93F332E.5BEC00AC-ON86256B52.00699C5C-@86256B52.0069BC41LocalDomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Boutcher wrote:


> You need to be running something like mingetty on the console to have
> signals (like ctrl-c) picked up.  If you start Linux with something like
> "init=/bin/bash" then job control signals (like control C and control Z)
> won't work.

One of the main reasons for this is the process in slot 1 (i.e. init)
has special signal handling in the kernel.  There are a variety of ways
to get a shell with job control running on the console.  Starting some
version of getty/mingetty as you mentioned is one, you can also fork a
shell and use stty to set signals, or anything to get a shell running
as process 2 or above.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
