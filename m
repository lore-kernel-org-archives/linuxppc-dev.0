From: "H.S. Kim" <root@localhost.localdomain>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Segmentation fault
Date: Fri, 6 Oct 2000 17:39:31 +0900
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00100618093700.11698@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


fitst, I week the english.

On the MBX860 board..
and NFS file system.

1.
I compiled the binutil, gcc,  kernel and glibc without errors.
binutil-2.20.0.26
gcc-2.95.2
mpc8xx-2.2.13
glibc-2.1.3

2.
And, I compiled the ash shell.
ash-linux-0.2

3.
And, I compiled the modutils.
modutils-2.3.9

4.
1, 2, 3 -> no error compiled and install.
but, ./modutils-2.3.9/insmod/insmod.c (refer to follow source)
first, segmentation error
==========================================
              if ((p = strrchr(filename, '/')) != NULL){
                      p++;
                      }
              else{
                      p = filename;
              }
*** Result ***
p = strrchr(filename,'/')  -> segmentation fault
================================================
So, i maked strrchr function.
==========================================
                len = strlen(p);

printf("MAIN_04_01\n");
                p=filename;
                for(i=len;i>0;i--)
                        p++;

printf("MAIN_04_02\n");
                for(i=1;i<=len;i++)
                        if(*(--p) == '/' ) {
                                p++;
                                break;
                        }
printf("MAIN_04_03\n");
                if(i<len)
                        p = filename;
***  Result  ****
len = strlen(p)   -> segmentation fault
=======================================
So, I remake strlen function
=======================================
              i=0;
              p=filename;
printf("MAIN_04_011\n");
              while(flag) {
printf("MAIN_04_012\n");
                      if(*(p) == '\0') flag=0;
printf("MAIN_04_013\n");
                      p++;
printf("MAIN_04_014\n");
                      i++;
              }
              len=i;

*** Result ***
MAIN_04_011
MAIN_04_012
Segmentation fault
======================================

But, when I make the simple program, no segmentation fault
==================================================
main(){

char *filename="fissslename";

 char  *p;
 char  *p1;
 char  ch;
 int i;
 int len;

p=filename;
len=strlen(filename);
printf("length=%d\n",len);
i=0;
while(1)
{
        if( *(p) == '\0') {printf("same\n"); break;}
        p++;
        i++;
        printf("%s\n",p);
}
printf("%d\n",i);

p1=(char *)malloc(i);
p1=filename;
printf("%s\n",p1);
}
*** Result ***
length=11
issslename
ssslename
sslename
slename
lename
ename
name
ame
me
e

same
11
fissslename
===============================================

The simple program excuted no segmentation.
but, insmod.c failed.

insmod.c and simple program has the same emvironment compile system and library.

what wrong??

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
