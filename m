Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <006801c3b571$408bc6e0$c314a8c0@cm>
From: "Sampath Kumar" <sampath@spartanlabs.com>
To: "Juergen Oberhofer" <e9826367@student.tuwien.ac.at>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>
Subject: Re: mpc / linux kernel - user space
Date: Fri, 28 Nov 2003 11:04:09 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Write an ioctl method in your module. And provide provision in ioctl to take
a function pointer & store it.
Whenever there is an timer interrupt, check for this pointer, if not NULL ,
then you can call the function. When your application comes up, makesure u
pass the command to ioctl of your module with the function pointer as arg.

Hope this help !

Regards
Sampath
----- Original Message -----
From: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, November 27, 2003 9:37 PM
Subject: mpc / linux kernel - user space


>
> Hi,
>
> I have a module and an application program in user space:
>
> The Module performs the following task: at init it initializes the cpm
> timer register of the mpc823,
> such that an interrupt is generated every x microseconds. Thus, I
> installed an interrupt handling function f that handles the timer
> interrupts.
>
> My problem is that the module / the interrupt handling function should
> execute a procedure defined in the application program. How can I pass a
> pointer (which points to that function) from the appl.program to the
> module, such that the handler can execute this function every x
> milliseconds? I thought to create a procedure in the module that accepts
> a function pointer as argument. But how can I achieve, that this module
> procedure is visible to the application program? Does somebody have a
> suggestion or know another way to do it?
>
> Regards,
> Juergen
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
