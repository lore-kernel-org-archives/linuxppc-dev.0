Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="============_-1280093432==_ma============"
Message-Id: <v04010108b3b35306d50b@power.elec.kitami-it.ac.jp>
Date: Thu, 15 Jul 1999 17:57:42 +0900
To: linuxppc-dev@lists.linuxppc.org
From: "T.Ueda" <ueda@power.elec.kitami-it.ac.jp>
Subject: Help! Fortran call from C on LinuxPPC-R5
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--============_-1280093432==_ma============
Content-Type: text/plain; charset="us-ascii"

Hi,

I am checking a simple program that Fortran calls C  using LinuxPPC-R5 on
PowerBookG3.

It seems that real fuction call of fortran may wrong.
Why 2147482368.000000 in the case of calling real function?? ( real and
float are not same bytes?)

Anyone know the reason?


Tac@Japan

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[complile& run]
 f77 -c f2.f
 f77 -c f22.f
 f77 -c f3.f
 f77 -c f33.f
 gcc main.c f2.o f22.o f3.o f33.o
 a.out
Result: 5  --> 25  2147482368.000000  125   125.000000

Why 2147482368.000000?? ( real and float are not same size?)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/*   (1)main.c  */
#include <stdio.h>

int main() {
  float y22, y33;
  int x=5;
  int y2, y3;

  y2=f2_(&x);
  y22=f22_(&x);
  f3_(&x, &y3);
  f33_(&x, &y33);
  printf("%d  --> %d  %f  %d   %f \n", x, y2, y22, y3, y33);
   return 0;
}
~~~~~~~~~~~~~~~~~~
C    (2)f2.f
    integer  function f2(x)
      integer x
      f2=x*x
      end
~~~~~~~~~~~~~~~~~~
C   (3) f22.f
      real function f22(x)
      integer x
      f22=x*x
      end
~~~~~~~~~~~~~~~~~~
C   (4) f3.f
      subroutine f3(x,y)
      integer x, y
      y=x*x*x
      end
~~~~~~~~~~~~~~~~~~
C   (5) f33.f
      subroutine f33(x,y)
      integer x
      real y
      y=x*x*x
      end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--============_-1280093432==_ma============
Content-Type: text/enriched; charset="us-ascii"

Hi,


<fontfamily><param>Courier</param>I am checking a simple program that
Fortran calls C  using LinuxPPC-R5 on PowerBookG3.


It seems that real fuction call of fortran may wrong.

Why 2147482368.000000 in the case of calling real function?? ( real and
float are not same bytes?)


Anyone know the reason?



Tac@Japan


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

[complile& run]

 f77 -c f2.f

 f77 -c f22.f

 f77 -c f3.f

 f77 -c f33.f

 gcc main.c f2.o f22.o f3.o f33.o

 a.out

Result: 5  --> 25  2147482368.000000  125   125.000000 


Why 2147482368.000000?? ( real and float are not same size?)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/*   (1)main.c  */

#include <<stdio.h>


int main() {

  float y22, y33;

  int x=5;

  int y2, y3;


  y2=f2_(&x);

  y22=f22_(&x);

  f3_(&x, &y3);

  f33_(&x, &y33);

  printf("%d  --> %d  %f  %d   %f \n", x, y2, y22, y3, y33);

   return 0;

}

~~~~~~~~~~~~~~~~~~

C    (2)f2.f

    integer  function f2(x)

      integer x

      f2=x*x

      end

~~~~~~~~~~~~~~~~~~

C   (3) f22.f

      real function f22(x)

      integer x

      f22=x*x

      end

~~~~~~~~~~~~~~~~~~

C   (4) f3.f

      subroutine f3(x,y)

      integer x, y

      y=x*x*x

      end

~~~~~~~~~~~~~~~~~~

C   (5) f33.f

      subroutine f33(x,y)

      integer x

      real y

      y=x*x*x

      end

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~</fontfamily>

--============_-1280093432==_ma============--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
