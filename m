Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 15 May 2003 08:31:05 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Rakesh Jagota <j.rakesh@gdatech.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How ?
In-Reply-To: <gqj62u6nur4vjg5.150520031028@gda-server>
Message-ID: <Pine.LNX.4.44.0305150828210.26702-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 15 May 2003, Rakesh Jagota wrote:
>  Can anyone suggest me how we can invoke the interrupt generated in the
> kernel from the user application. I am getting the interrupt in the driver, I
> want to update some register in the application, when the inettrupt will be
> generated, Right now I am using polloing method. Continuously I am calling
> read routines.

Don't know why you want to handle it from user space, but the easiest way
to notify an application would be to send a signal. Have a special ioctl()
to notify the driver that this application wants a signal, and then when
the driver receives the interrupt it clears the condition and sends a
signal to the registered application(s).

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
