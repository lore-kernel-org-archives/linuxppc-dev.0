Date: Sun, 6 Aug 2000 08:46:39 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Olaf Hering <olh@suse.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question
In-Reply-To: <20000806150611.A4180@suse.de>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000806083118.1409E-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Aug 2000, Olaf Hering wrote:

> Can you send me a diff against the current Benh kernel?

You mean his 2.2.x tree?  Or does he have 2.4.x tree somewhere?  I'm only
working with 2.4.x.

> I just inserted these (useless) printk() to a non called function and
> now it works so far for me.
>
> find_pci_device_OFnode(unsigned char bus, unsigned char dev_fn)
> {
> /*      char blubber[60] = ""; */
>         struct device_node* np;
>         unsigned int *reg;
>         int l;
> /*      printk("I am just a dummy ...\n");  */
>         for (np = allnodes; np != 0; np = np->allnext) {
>                 int in_macio = 0;
>                 struct device_node* parent = np->parent;
>                 while(parent) {
>                         char *pname = (char *)get_property(parent, "name", &l);
>         printk("I am just another dummy ...\n");
>         printk("I am just another dummy ...\n");
>                         if (pname && strcmp(pname, "mac-io") == 0) {
>                                 in_macio = 1;
>                                 break;
>                         }
>
> Bit ugly.

I bet you get the same effect (working kernel) by placing the printk()s
elsewhere.  I know something strange (to me) is going on, but I haven't
found anything wrong in objdump of prom.o.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
