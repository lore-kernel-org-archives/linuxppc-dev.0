Message-Id: <m11dxqy-0000WVC@tri-yann.crf.canon.fr>
Date: Wed, 20 Oct 1999 17:40:40 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: gcc-bugs@gcc.gnu.org
Subject: Incorrect optimization on PowerPC due to volatile keyword (gcc-2.95.1 official)
Cc: joel@oarcorp.com, valette@crf.canon.fr, raguet@crf.canon.fr,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        valette@crf.canon.fr
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Environment information
-----------------------
53 powermac1:/tmp->uname -a
Linux powermac1 2.2.12 #1 Sat Sep 4 17:53:53 MDT 1999 ppc unknown
54 powermac1:/tmp->gcc -v
Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.1/specs
gcc version 2.95.1 19990816 (release)

Proof of uncorrect behavior
---------------------------

gcc  -o t t.c    
t.c: In function `IMFS_get_token':
t.c:80: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
t.c:82: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
48 powermac1:/tmp->t
token = dev			<============= correct
49 powermac1:/tmp->gcc -O2 -o t t.c 
t.c: In function `IMFS_get_token':
t.c:80: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
t.c:82: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
50 powermac1:/tmp->t
token = d			<============= WRONG
51 powermac1:/tmp->gcc -O4 -o t t.c 
t.c: In function `IMFS_get_token':
t.c:80: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
t.c:82: warning: passing arg 1 of `strcmp' discards qualifiers from pointer target type
52 powermac1:/tmp->t
token = dev			<============= correct again
52 powermac1:/tmp

   *******************************************************************
The problem is in the generation of the first while loop in the program below
   *******************************************************************

FYI : We have experienced a lot of problem when compiling drivers using the
volatile keyword to access memory mapped PCI board registers. The problems
were not present in egcs-1.1.2.

   ------------------- t.c program -------------------------------

#include <stdlib.h>

#define IMFS_is_valid_name_char( _ch ) ( 1 )

#define IMFS_is_separator( _ch ) \
   rtems_filesystem_is_separator( _ch )

#define rtems_filesystem_is_separator( _ch ) \
   ( ((_ch) == '/') || ((_ch) == '\\') || ((_ch) == '\0'))

#define IMFS_NAME_MAX  32

/*
 *  Type defination for tokens returned from IMFS_get_token
 */

typedef enum {
  IMFS_NO_MORE_PATH,
  IMFS_CURRENT_DIR,
  IMFS_UP_DIR,
  IMFS_NAME,
  IMFS_INVALID_TOKEN
} IMFS_token_types;

IMFS_token_types IMFS_get_token(
  volatile const char       *path,
  volatile char             *token,
  volatile int              *token_len
)
{
  int               i = 0;
  IMFS_token_types  type = IMFS_NAME;

  /* 
   *  Copy a name into token.  (Remember NULL is a token.)
   */

  while ( !IMFS_is_separator( path[i] ) && (i <= IMFS_NAME_MAX) ) {

     token[i] = path[i];

     if (i == IMFS_NAME_MAX)
       return IMFS_INVALID_TOKEN;

     if ( !IMFS_is_valid_name_char( token[i] ) )
       type = IMFS_INVALID_TOKEN;   

     i++;
  }

  /*
   *  Copy a seperator into token.
   */

  if ( i == 0 ) {
    token[i] = path[i];

    if ( token[i] != '\0' ) {
      i++;
      type = IMFS_CURRENT_DIR;
    } else {
      type = IMFS_NO_MORE_PATH;
    }
  } else if (token[ i-1 ] != '\0') {
    token[i] = '\0';
  }

  /*
   *  Set token_len to the number of characters copied.
   */

  *token_len = i;

  /*
   *  If we copied something that was not a seperator see if
   *  it was a special name.
   */

  if ( type == IMFS_NAME ) {
    if ( strcmp( token, "..") == 0 )
      type = IMFS_UP_DIR;
    else if ( strcmp( token, "." ) == 0 )
      type = IMFS_CURRENT_DIR;
  }

  return type;
}

main()
{
  IMFS_token_types  type;
  char token[ IMFS_NAME_MAX + 1 ];
  char path [4];
  int len;
  int i = 0;
  
  strcpy(path, "dev");
  memset(token, 0, sizeof(token));
  type = IMFS_get_token( &path[i], token, &len );
  printf("token = %s\n", token);
}


-- 
   __                 
  /  `                   	Eric Valette
 /--   __  o _.          	Canon CRF - Communication Dept
(___, / (_(_(__         	Rue de la touche lambert
				35517 Cesson-Sevigne  Cedex
				FRANCE
Tel: +33 (0)2 99 87 68 91	Fax: +33 (0)2 99 84 11 30
E-mail: valette@crf.canon.fr	http://www.crf.canon.fr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
