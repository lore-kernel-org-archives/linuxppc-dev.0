Message-ID: <F7B644B6C3C7D41191F700B0D06888190AAAE3@optic3.ipoptical.com>
From: Huy Vu <huy.vu@ipoptical.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: vxhack and mvista kernel
Date: Thu, 14 Dec 2000 11:40:33 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C065EC.93D9DDF0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C065EC.93D9DDF0
Content-Type: text/plain

All,

Here's the hacked up "vxhack" for LE (ie. x86) hosts...

Cheers
Huy

P.S. I hope my assumptions are correct :-)


------_=_NextPart_000_01C065EC.93D9DDF0
Content-Type: application/octet-stream;
	name="vxhack.c"
Content-Disposition: attachment;
	filename="vxhack.c"
Content-Transfer-Encoding: quoted-printable


/* Crudely convert the zImage so the VxWorks boot rom will load it.
 * Copyright (c) 2000 MontaVista Software, Inc.
 * Dan Malek (dmalek@jlc.net).
 *
 * Modified for LE problems Dec 14, 2000 Huy Vu (huy.vu@ipoptical.com)
 */
#include <sys/types.h>
#include <fcntl.h>
#include <string.h>
#include <elf.h>
#include <stdio.h>

#define IBSIZE	(64*1024)
u_char	ibuf[IBSIZE];
u_char	dbuf[IBSIZE];

#define PGSZ	4096
#define roundup(x)	(((x) + (PGSZ-1)) & ~(PGSZ-1))

main (int argc, char **argv)
{
	int	elf_fd, bin_fd, npscns, nsscns, size, dsize;
	int	shoff, shentsize, i, shsize, imagesize;
	char	*outname, *malloc(), *sp;
	Elf32_Ehdr	*ehp;
	Elf32_Phdr	*epp;
	Elf32_Shdr	*shp;
	int	found =3D 0;

	if (argc !=3D 2)
		usage(argv[0]);

	if ((elf_fd =3D open(argv[1], O_RDWR)) < 0) {
		perror("Image open");
		exit(1);
	}

	/* Read the ELF header on the front of the image and get
	 * some information from it.
	 */
	if (read(elf_fd, ibuf, sizeof(ibuf)) !=3D sizeof(ibuf)) {
		fprintf(stderr, "%s doesn't have ELF header\n", argv[1]);
		exit(2);
	}
	ehp =3D (Elf32_Ehdr *) ibuf;

	if (strncmp(ehp->e_ident, ELFMAG, 4) !=3D 0) {
		fprintf(stderr, "%s doesn't have ELF header\n", argv[1]);
		exit(2);
	}

	npscns =3D ntohs(ehp->e_phnum);
	nsscns =3D ntohs(ehp->e_shnum);
	shoff =3D ntohl(ehp->e_shoff);
	shentsize =3D ntohs(ehp->e_shentsize);

#ifdef VXHACK_DEBUG
	printf("npscns=3D%x\n",ntohs(ehp->e_phnum));
	printf("nsscns=3D%x\n",ntohs(ehp->e_shnum));
	printf("shoff=3D%x\n",ntohl(ehp->e_shoff));
	printf("shentsize=3D%x\n\n",ntohs(ehp->e_shentsize));
#endif


	epp =3D (Elf32_Phdr *)((uint)ehp + ntohl(ehp->e_phoff));

	/* Read the section headers.
	*/
	if (lseek(elf_fd, shoff, 0) < 0) {
		perror("seek");
		exit(2);
	}

	if ((shsize =3D read(elf_fd, dbuf, sizeof(dbuf))) < 0) {
		fprintf(stderr, "%s doesn't have ELF header\n", argv[1]);
		exit(2);
	}

	/* Scan all of the section headers, updating the address so
	 * it will load at 0x900000.  We know lots about zImage here,
	 * so if that ever changes (it shouldn't) we must do the same.
	 *
	 * The section we are interested in is the first zero sh_addr
	 * that is not the first section! (huy.vu@ipoptical.com)
	 * This is a correct assumption (I hope) :-)
	 *
	 * I am not sure any of this is necessary, as I suspect the
	 * VxWorks rom doesn't really read the section headers.
	 */
	shp =3D (Elf32_Shdr *) dbuf;
	sp =3D (char *)shp;
	for (i=3D0; i<nsscns; i++) {
		if (shp->sh_addr)
			shp->sh_addr =3D htonl(ntohl(shp->sh_addr)+0x500000);
		else if (!found && i)
		{
			found =3D 1;
			imagesize =3D ntohl(shp->sh_size);
		}
#ifdef VXHACK_DEBUG
		printf("%d---\n",i);
		printf("sh_addr=3D%x\n", ntohl(shp->sh_addr));
		printf("imagesize=3D%x\n", imagesize);
		printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
#endif
 		sp +=3D shentsize;
		shp =3D (Elf32_Shdr *)sp;
	}
	if (!imagesize)
		exit(2);

	/* Now that we know the zImage size, and we know it's offset
	 * in the file is a 4k page boundary after the data section,
	 * update the data section to include the zImage.
	 * We know the data section is number 3.
	 */
	shp =3D (Elf32_Shdr *) dbuf;
	sp =3D (char *)shp;
	sp +=3D (3 * shentsize);
	shp =3D (Elf32_Shdr *)sp;
	shp->sh_size =3D htonl(ntohl(shp->sh_size)+4095);
	shp->sh_size =3D htonl(ntohl(shp->sh_size) & ~4095);		/* Round up to =
4K page boundary */
	shp->sh_size =3D htonl(ntohl(shp->sh_size) + imagesize);	/* Add zImage =
size */

	/* Write out the new section headers.
	*/
	if (lseek(elf_fd, shoff, 0) < 0) {
		perror("seek");
		exit(2);
	}

	if (write(elf_fd, dbuf, shsize) !=3D shsize)
		perror("write");

	/* Now go back and hack up the program header on the front of
	 * the image.  We know these are fixed offsets in the header.
	 * I suspect (although not tested), this is really all that is
	 * necessary to make the VxWorks loader read our image.
	 */
	ehp->e_entry =3D htonl(ntohl(ehp->e_entry)+0x00500000);

	/* Now the program header.
	*/
	epp->p_vaddr =3D htonl(ntohl(epp->p_vaddr)+0x00500000);		/* Segment =
virtual address */
	epp->p_paddr =3D htonl(ntohl(epp->p_paddr)+0x00500000);	/* Segment =
physical address */
	epp->p_filesz=3D htonl(ntohl(epp->p_filesz)+4095);
	epp->p_filesz=3D htonl(ntohl(epp->p_filesz) & ~4095);
	epp->p_filesz=3D htonl(ntohl(epp->p_filesz)+imagesize);		/* Segment =
size in file */
	epp->p_memsz =3D htonl(ntohl(epp->p_memsz)+imagesize);		/* Segment =
size in memory */

	if (lseek(elf_fd, 0, 0) < 0) {
		perror("lseek");
		exit(2);
	}
	if (write(elf_fd, ibuf, sizeof(ibuf)) !=3D sizeof(ibuf)) {
		fprintf(stderr, "%s header write failed\n", argv[1]);
		exit(2);
	}

	exit(0);

}

usage(char *name)
{
	fprintf(stderr, "Usage: %s zImage_file\n", name);
	exit(2);
}

------_=_NextPart_000_01C065EC.93D9DDF0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
