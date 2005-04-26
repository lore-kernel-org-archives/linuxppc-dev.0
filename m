Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id D264167A33
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 23:27:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Tue, 26 Apr 2005 15:27:35 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B23@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Booting linux for 405EP --> mem_pieces_find( ) nightmare
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,
I'm tryin to adapt a linux LSP deom Montavista (the one for the 405EP =
evaluation board) to a proprietary hardware using a 405EP.
Unfortunately, it is not as easy as I thought. Here is my problem:
To load our linux image (zImage.treeboot), we use the "VxWorks bootrom" =
bootloader which download the image via tftp.
That works well except the fact that in the LSP, linux tried to get a =
board info structure in flash memory at an address where we have =
nothing. So we replace this behavior in "embed_config.c" with the =
following lines (note: I had to re-code the strcpy although there is the =
#include<string.h> because it cannot find the reference at the link =
level... why???):

/* We use VxWorks bootrom, so we have to create ourselves the boot info =
structure */
bd_t my_bd_t;
   =20
char * my_strcpy(char * dest,const char *src)
{
  char *tmp =3D dest;

  while ((*dest++ =3D *src++) !=3D '\0')
    /* nothing */;
  return tmp;
}


bd_t * get_board_info(void)
{
  my_strcpy(my_bd_t.bi_s_version,"v1");                  /*  Version of =
this structure   */
  my_strcpy(my_bd_t.bi_r_version,"bootrom linux 1.0") ;  /*  Version of =
the IBM ROM      */
  my_bd_t.bi_memsize      =3D 16000000 ;                   /* DRAM =
installed, in bytes     */
  my_strcpy(my_bd_t.bi_enetaddr[0],"00:01:73:01:C1:3B"); /* Local =
Ethernet MAC address   */
  my_strcpy(my_bd_t.bi_enetaddr[1],"00:01:73:01:C1:3C"); /* Local =
Ethernet MAC address   */
  my_bd_t.bi_intfreq      =3D 200000000 ;     /* Processor speed, in Hz  =
     */
  my_bd_t.bi_busfreq      =3D 100000000 ;     /* PLB Bus speed, in Hz    =
     */
  my_bd_t.bi_pllouta_freq =3D 800000000 ;     /* PLL OUTA speed, in Hz   =
     */
  my_bd_t.bi_opb_busfreq  =3D 50000000 ;      /* OPB Bus speed, in Hz    =
     */
  my_bd_t.bi_iic_fast[0]  =3D 0 ;             /*  Use fast i2c mode      =
     */

  /* We return the address of our global structure */
  return &my_bd_t;
}

void embed_config(bd_t **bdp)
{
  u_char	*cp;
  int	i;
  bd_t	*bd, *treeboot_bd;

  bd =3D &bdinfo;
  *bdp =3D bd;
  if ((treeboot_bd =3D get_board_info()) !=3D NULL)
    memcpy(bd, treeboot_bd, sizeof(bd_t));
  else
  {
    /* Give default values for our board info structure */
    bd->bi_memsize =3D 16 * 1024 * 1024;
    cp =3D (u_char *)def_enet_addr;
    for (i=3D0; i<6; i++)
    {
      /* I should probably put different ones here,
       * hopefully only one is used.
       */
      bd->BD_EMAC_ADDR(0,i) =3D *cp;
    }
    bd->bi_intfreq =3D 200000000;
    bd->bi_busfreq =3D 500000000;
  }
  /* Yeah, this look weird, but on Redwood 4 they are
   * different object in the structure.  Sincr Redwwood 5
   * and Redwood 6 use OpenBIOS, it requires a special value.
   */
  timebase_period_ns =3D 1000000000 / bd->bi_tbfreq;
}


That done, the linux booting process continues till the "MMU_init()" =
function, that drives me to the panic() function when it tries to do the =
mem_pieces_find() (see below).

/*
 * Scan a region for a piece of a given size with the required =
alignment.
 */
void __init *
mem_pieces_find(unsigned int size, unsigned int align)
{
	int i;
	unsigned a, e;
	struct mem_pieces *mp =3D &phys_avail;

	for (i =3D 0; i < mp->n_regions; ++i) {
		a =3D mp->regions[i].address;
		e =3D a + mp->regions[i].size;
		a =3D (a + align - 1) & -align;
		if (a + size <=3D e) {
			mem_pieces_remove(mp, a, size, 1);
			return (void *) __va(a);
		}
	}
	panic("Couldn't find %u bytes at %u alignment\n", size, align);        =
/* <-- HERE WE GO !!.... */
=09
	return NULL;
}


I have no clue on what's happening (I'm a newbie in kernel sources =
dev...). Could you give me a tip please cause I really need help on =
that.
Tks a lot

J=E9r=E9mie        \\ (=B0.=B0) //~ ~ ~ HELP ~ ~ ~ \\ (=B0.=B0) //
