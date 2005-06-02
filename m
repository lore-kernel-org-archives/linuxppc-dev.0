Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id BA057679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 23:04:08 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 2 Jun 2005 15:00:26 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B30@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <Jeff.Fellin@rflelect.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : RE : copy_from_user( ) problem...help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok Jeff. Thanks a lot for your help and let me congratulate you for your =
answer's quality.
Really you're a treasure for people like me.=20
Nevertheless, I tried another way using ioctl() and that works very well =
and with your explanations
I understand now why. So it's all process context related.

Have a nice day and thks again, sincerly
J=E9r=E9mie



-------- Message d'origine--------
De: Jeff.Fellin@rflelect.com [mailto:Jeff.Fellin@rflelect.com]
Date: jeu. 02/06/2005 14:21
=C0: Garcia J=E9r=E9mie
Objet : RE : copy_from_user( ) problem...help
=20

Jeff Fellin
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327


                                                                         =
                                             =20
                      Garcia J=E9r=E9mie                                 =
                                                 =20
                      <GARCIAJ@3il.fr>         To:       =
<Jeff.Fellin@rflelect.com>                                   =20
                                               cc:                       =
                                             =20
                      06/02/2005 04:27         Subject:  RE : =
copy_from_user( ) problem...help                        =20
                                                                         =
                                             =20
                                                                         =
                                             =20




I'm sorry to be such a newbie in Linux, but I don't understand why the
problem
would be process-related.
      As described in Linux Kernel Development by Robert Love under =
Process
Management, section
      Process Context: When a process a system call it enters kernel =
state.
At this point the
      kernel is said to be "executing on behalf of the user process" and =
is
in process context.

      The kernel is not a self-executing process. It only executes on
interrupts or user process
      requests. When executing on user process request, the only visible
user space is the user
      address space of the process invoking the system call. Not all =
user
processes are
      addressable.

Cause the copy_from_user() just needs an user-space address whatever is =
the
process. Isn't it
what I do here?
      Yes, it needs a user-space address, at the address is dereferenced
using the current             processes address mapping. In your example =
of
a small process all of it's addresses
      would probably exist in any other process. However, for the kernel =
to
reference the
      address space of a process not executing the system call requires
finding the page
      table of the process and then decoding the address to the physical
address, mapping that
      address into the kernel, and copying the data into the kernel.


So how would that kernel routine be usable?
      The routine is usable, but only within the context of the current
process, not an
      arbitary process. See Chapter 4, System calls for more reasons.

Could you give me a little more explanations? And could you tell me if =
what
I want to do
is possible using that way and what I missed?
      I hope the above and references are sufficient explanation. There =
is
no possible method
      to pass addresses from different processes into the kernel. You =
must
always obey the
      Process Context concept. Others have suggested methods to resolve
this issue via sysfs,
      which is also described in Rober Love's book. I suggest you =
purchase
this and read it
      before continuing.


-------- Message d'origine--------
De: Jeff.Fellin@rflelect.com [mailto:Jeff.Fellin@rflelect.com]
Date: mer. 01/06/2005 16:48
=C0: Garcia J=E9r=E9mie
Objet : Re: copy_from_user( ) problem...help


Jeremie,
The Address you give is to the user process to your kernel is an address =
in
the insmod
process, which is the actual user process your module is referencing. =
You
can verify this
by printing out the process id's in your user command, and the
current->pid, in your module.
They should be different, and the current->pid in your module should be =
the
PID of the insmod
command.

Jeff Felline insmod
RFL Electronics
Jeff.Fellin@rflelect.com
973 334-3100, x 327



                      Garcia J=E9r=E9mie

                      <GARCIAJ@3il.fr>            To:
<linuxppc-dev@ozlabs.org>
                      Sent by:                    cc:

                      linuxppc-dev-bounces        Subject:  =
copy_from_user(
) problem...help
                      @ozlabs.org


e insmod (you c
                      06/01/2005 10:00







Hi everybody,
I'm tryin to write some device drivers modules in order to manage some =
of
our devices of our ppc405EP based board.
I read the Allessandro Rubini book (Linux Kernel device drivers) in =
order
to help me.
Before going on difficult stuff, I'd like to make some basic training =
and
experiments.
What I want to do seems to be very easy (but...):
 - a user space programm has a global structure and contains an integer =
and
a char
 - the user space programm loads the module with a parameter: the =
structure
address
 - during the init_module(),I check that the address can be accessed in =
R/W
mode with the access_ok()
 - the module copies the user structure in its own context and prints =
the
values retreived

So, it's supposed to be a very easy operation, but something goes wrong.
Could someone give me a clue cause
I read it again and again and I don't get what's the matter. Here is the
code:

/************************************************************************=
******/


/*                           USER SPACE PROG
*/
/************************************************************************=
******/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct une_structure
{
    int un_entier;
    char un_char;
}UNE_STRUCTURE;

UNE_STRUCTURE my_structure;

void main(void)
{
    char buff[100];

    /* Init of the structure */
    my_structure.un_entier =3D 5;
    my_structure.un_char =3D 'a';

    /* Build the shell command to load the module */
    sprintf(buff,"insmod -q ./un_module.o addr=3D%p",&my_structure);

    /* Print the shell command that loads the module */
    printf("\nCommmande : ");
    puts(buff);

    /* Load the module*/
    system(buff);

    sleep(2);

    /* Remove the module */
    system("rmmod un_module");
}


/************************************************************************=
/
/*                      KERNEL MODULE                                   =
*/
/************************************************************************=
/
[...]
typedef struct une_structure
{
    int un_entier;
    char un_char;
}UNE_STRUCTURE;

UNE_STRUCTURE *addr =3D 0x0;  /* default value */

MODULE_PARM(addr,"l");      /* get the address of the user space =
structure
                               given in argument at insmod()
*/


int init_module(void)
{
  int rc;
  UNE_STRUCTURE * my_structure;

  printk("Address of the user structure : %d\n",(int)addr);

  /* Alloc space for ou structure */
  my_structure =3D kmalloc(sizeof(UNE_STRUCTURE),GFP_DMA);
  if(my_structure=3D=3DNULL)
  {
    printk("Kernel memory allocation failed!\n");
    return -1;
  }
  else
    printk("Kernel memory allocation succeeded!\n");

  rc =3D access_ok(VERIFY_READ,(void *)addr,sizeof(UNE_STRUCTURE));
  if(rc !=3D 0)
  {
     rc =3D access_ok(VERIFY_WRITE,(void *)addr,sizeof(UNE_STRUCTURE));
     if(rc !=3D 0)
     {
          rc =3D copy_from_user(my_structure,(void
*)addr,sizeof(UNE_STRUCTURE));
          if(rc)
              printk("Error in copy_from_user, rc=3D%d\n",rc);
          else
          {
            printk("Values of the retreived user-space structure 's
fields:\n");
            printk("\t -> un_entier =3D %d \n",my_structure->un_entier);
            printk("\t -> un_unsigned_char =3D %c =
\n",my_structure->un_char);
          }

      }
      else
      {
          printk("Erreur in accessing addr in WRITE mode\n");
          return -1;
      }
    }
    else
    {
      printk("Erreur in accessing addr in READ mode\n");
      return -1;
    }
    return 0;
}

/************************************************************************=
***/


/*                         EXECUTION RESULTS
*/
/************************************************************************=
***/


root@10.16.9.232:/home/testDir# ./une_appli.exe

[USER-SPACE]Commmande : insmod -q ./un_module.o addr=3D0x10010a74
[KERN-SPACE]Address of the user structure : 268503668               // =
is
the same if converted in hexa
[KERN-SPACE]Kernel memory allocation succeeded!
[KERN-SPACE]Values of the retreived user-space structure 's fields:
               -> un_entier =3D -1857486844                           //
weird result and !=3D 5
               -> un_unsigned_char =3D .                              //
weird result and !=3D 'a'

[KERN-SPACE]Now releasing the module...


As you can see, I don't really retreived the user-space structure in the
kernel. Is it an address problem?
If I understood well, no ioremap is needded here cause the address given =
in
argument of insmod is from MMU.
So what's the problem ; I really think that I'm dealing with a wrong
address.

Please help a newbie that would like to understand... Tks for your =
precious
help.
Jeremie

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
