Message-ID: <3C02979B.8B787B8C@mvista.com>
Date: Mon, 26 Nov 2001 11:27:23 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Using BDI2000 for module debugging
References: <B164B53F5BD6D511888D009027732E1A02497B@ntserver.act.domain>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I have a particular module that crashes the system during installation.
> What is the best way to use BDI2000 to stop on the first instruction of the
> init_module()?
>
> I can do kernel debugging with BDI2000, but I am not sure how to get to the
> dynamically loaded modules.

This info was correct for 2.4.2, I don't know if it is still correct.  I
used this method for KGDB, but it should work for the BDI2000 too.

Set a breakpoint in sys_init_module() at a place after the module has
been loaded, but before the init routine has been called.  Here's
where I did it in 2.4.2:


        /* Free our temporary memory.  */
        put_mod_name(n_name);
        put_mod_name(name);

        /* Initialize the module.  */
        mod->flags |= MOD_INITIALIZING;
        atomic_set(&mod->uc.usecount,1);


breakpoint here, before the "mod->init()"....


        if (mod->init && (error = mod->init()) != 0) {
                atomic_set(&mod->uc.usecount,0);
                mod->flags &= ~MOD_INITIALIZING;
                if (error > 0)  /* Buggy module */
                        error = -EBUSY;
                goto err0;
        }


>From the breakpoint in sys_init_module(), you can set a breakpoint in
the module's init_module()


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
