From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
To: Michel Daenzer <michdaen@iiic.ethz.ch>
Date: Wed, 31 Jan 2001 20:29:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Subject: Re: [linux-fbdev] Re: r128 DRI driver now fully functional 
CC: andi@convergence.de, benh@kernel.crashing.org,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        geert@linux-m68k.org
Message-ID: <142B99D154AF@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 31 Jan 01 at 19:53, Michel Dänzer wrote:
> > The disadvantage is that if you change the palette, the text colors don't
> > change until you redraw the screen (or switch VC back-and-forth). That's why
> > I decided to use the hardware palette in directcolor modes.
>
> I don't mind using the hardware palette if you (or anyone) tell me how to get
> RGB565 working with that. :)

It depends on how your hardware works:

If it uses palette entries 0-31 for R/B and 0-63 for G, program
dispsw_data pointed array (pseudo_palette) with

for (i = 0; i < 16; i++) arr[i] = i * ((1 << 11) | (1 << 5) | 1);

and your setcolreg should program r,g,b fields for regno register.

If your hardware uses entries 0,8,16,24...248 for R/B and
0,4,8,12,... for G, things are worse:

program pseudo_palette with same 'arr[i] = i * ((1 << 11) | (1 << 5) | 1);'

But setcolreg is much worse:

if (regno) {
  if (regno & 1) {
    oldR = oldB = 0;
  } else {
    outb(regno * 4, PALETTE_R_INDEX);
    oldR = inb(PALETTE_DATA);
    inb(PALETTE_DATA);
    oldG = inb(PALETTE_DATA);
  }
  outb(regno * 4, PALETTE_W_INDEX);
  outb(oldR, PALETTE_DATA);
  outb(g, PALETTE_DATA);
  outb(oldB, PALETTE_DATA);

  outb(regno * 8, PALETTE_R_INDEX);
  inb(PALETTE_DATA);
  oldG = inb(PALETTE_DATA);
  inb(PALETTE_DATA);
} else {
  oldG = g;
}
outb(regno * 8, PALETTE_W_INDEX);
outb(r, PALETTE_DATA);
outb(oldG, PALETTE_DATA);
outb(g, PALETTE_DATA);

I think that you should create 3x256 (or 3x64) array which will mirror
DAC state, as otherwise you have to do too many ops to set
one register...

Also do not forget that you must use only low 16 color registers (regno
on input to setcolreg) for text console, as others (16-31/16-63) are not
saved/restored by console palette handling code.
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
