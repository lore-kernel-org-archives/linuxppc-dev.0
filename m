Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id 6DF2F679E2
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 00:00:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 1 Jun 2005 16:00:25 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B2D@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: copy_from_user( ) problem...help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'm tryin to write some device drivers modules in order to manage some =
of our devices of our ppc405EP based board.
I read the Allessandro Rubini book (Linux Kernel device drivers) in =
order to help me.
Before going on difficult stuff, I'd like to make some basic training =
and experiments.
What I want to do seems to be very easy (but...):
 - a user space programm has a global structure and contains an integer =
and a char
 - the user space programm loads the module with a parameter: the =
structure address
 - during the init_module(),I check that the address can be accessed in =
R/W mode with the access_ok()
 - the module copies the user structure in its own context and prints =
the values retreived

So, it's supposed to be a very easy operation, but something goes wrong. =
Could someone give me a clue cause
I read it again and again and I don't get what's the matter. Here is the =
code:

/************************************************************************=
******/
/*                           USER SPACE PROG                             =
     */
/************************************************************************=
******/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
 =20
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
   =20
    /* Build the shell command to load the module */
    sprintf(buff,"insmod -q ./un_module.o addr=3D%p",&my_structure);

    /* Print the shell command that loads the module */
    printf("\nCommmande : ");
    puts(buff);
   =20
    /* Load the module*/
    system(buff);

    sleep(2);

    /* Remove the module */
    system("rmmod un_module"); =20
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
structure=20
                               given in argument at insmod()             =
  */


int init_module(void)
{
  int rc;
  UNE_STRUCTURE * my_structure;
 =20
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
  {      =20
     rc =3D access_ok(VERIFY_WRITE,(void *)addr,sizeof(UNE_STRUCTURE));
     if(rc !=3D 0)
     {
          rc =3D copy_from_user(my_structure,(void =
*)addr,sizeof(UNE_STRUCTURE));
          if(rc)
              printk("Error in copy_from_user, rc=3D%d\n",rc);
          else
          { =20
            printk("Values of the retreived user-space structure 's =
fields:\n");
            printk("\t -> un_entier =3D %d \n",my_structure->un_entier);
            printk("\t -> un_unsigned_char =3D %c =
\n",my_structure->un_char);
          }
            =20
      }
      else
      {
          printk("Erreur in accessing addr in WRITE mode\n");
          return -1;
      }=20
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
/*                         EXECUTION RESULTS                             =
  */
/************************************************************************=
***/
root@10.16.9.232:/home/testDir# ./une_appli.exe

[USER-SPACE]Commmande : insmod -q ./un_module.o addr=3D0x10010a74
[KERN-SPACE]Address of the user structure : 268503668               // =
is the same if converted in hexa=20
[KERN-SPACE]Kernel memory allocation succeeded!
[KERN-SPACE]Values of the retreived user-space structure 's fields:
               -> un_entier =3D -1857486844                           // =
weird result and !=3D 5
               -> un_unsigned_char =3D .                              // =
weird result and !=3D 'a'

[KERN-SPACE]Now releasing the module...


As you can see, I don't really retreived the user-space structure in the =
kernel. Is it an address problem?
If I understood well, no ioremap is needded here cause the address given =
in argument of insmod is from MMU.
So what's the problem ; I really think that I'm dealing with a wrong =
address.=20

Please help a newbie that would like to understand... Tks for your =
precious help.
Jeremie
=20
