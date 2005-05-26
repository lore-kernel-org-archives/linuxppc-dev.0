Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 4F0E4679F9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 20:09:53 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 26 May 2005 12:09:51 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2C@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: How to register a user-space function as an interrupt handler ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody, I'm tryin to adapt a vxWorks-designed application to a =
Linux montavista 3.1 on a board=20
running a powerPC 405 EP. In our application, that will be run from the =
linux user-space, we connect a
routine to an interrupt vector as the example below:

/**************************/
/* /home/JG/appli/ppcos.c */
/**************************/

RET_CODE_TYPE enable_and_connect_DMA(MY_DMA_CTRL * my_param)
{
    BS_RET_CODE_TYPE rc1 =3D BS_RET_OK;=20

    /* Connect interrupt handler for each channel */
    rc =3D intConnect((VOIDFUNCPTR *)INT_VEC_DMA, my_handler, =
(int)my_param);
  =20
    if(!rc)
        /* Enable interrupt for first channel in the interrupt =
controller */
        intEnable(INT_LVL_DMA_CH0);

    else
        rc1 =3D BS_RET_ERROR;
    =20
    return rc1;
}

What I would like to do is to make an emulation of both vxWorks routines =
(intConnect() and intEnable()) in the linux world
cause I'm not allowed to change that code.
I guess that I will have to use :
   intConnect() <=3D=3D> request_irq()
   intEnable()  <=3D=3D> enable_irq()
(Is that correct??).
Furthermore, I'm a newbie in linux developpment and if I understand =
well, I need to be in kernel-space to call those routines.=20
But here is my problem: the interrupt handler that we call is part of =
the application and uses a lot of #define,semaphores and other=20
ressources of the user-application. So can I implement a new linux =
system call, that will register our user-space-function (my_handler())
as the interrupt handler for the given vector?? Indeed, we do that for =
several interrupts (each with a different handler) and it would
be comfortable to have a system call that would take (the handler + the =
interrupt vector + the parameters) as parameters.
Don't forget that I have to respect two conditions: my application must =
be run from user-space and I cannot modify the=20
code (my team does not want to support versions).

Please help or give me a clue.

Thanks for your precious help.
J=E9r=E9mie
