Date: Wed, 29 Mar 2000 15:47:26 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: adb_buttons kernel argument
In-Reply-To: <00032911415300.05568@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10003291432360.15402-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have just realized that with 2.3.xx (since 2.3.18) the format of the
> arguments for the adb_buttons=xxx kernel command-line argument has
> changed.  With 2.2 you can say adb_buttons=1 to emulate buttons 2 and 3
> with the right control and option keys, or you can say adb_buttons=xx,yy
> to use keycodes xx and yy to emulate buttons 2 and 3.  With 2.3 you now
> have to say adb_buttons=1,xx,yy.

That explains my problems with adb_buttons in 2.3.48 - though I had looked
for a different cause. By accident the values for yy was xx + 8 on my
machine, and the xev output for button x was xx + 8 as well ...

> I propose to change 2.3 back to the 2.2 behaviour since that is what is
> documented.  Does anybody have any problem with that?

Please change it back. Or make it look like

static int __init adb_mouse_setup(char *str)
{
        int ints[4]={-1,-1,-1,-1};

        str = get_options(str, ARRAY_SIZE(ints), ints);
 	if ( ints[0] > 0
             && (adb_emulate_buttons = (ints[1] >=0)||(ints[2] >=0)) ) {
		if (ints[1] > 1)
	                adb_button2_keycode = ints[1];
	        if (ints[0] >= 2 && ints[2] >= 0)
                        adb_button3_keycode = ints[2];
        }
        return 1;
}

	Michael

P.S.: Did you ever receive my 2.3.48 adb.c patch?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
