Message-Id: <199907282103.RAA28451@thanatopsis.mit.edu>
To: Alain Birtz <abz@videotron.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Realloc() problem with Efence 
In-Reply-To: Your message of "Wed, 28 Jul 1999 16:48:42 CDT."
             <379F7AB9.E8D230CE@videotron.ca>
Date: Wed, 28 Jul 1999 17:03:39 -0300
From: Nicholas T Ingolia <ingolia@MIT.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


-----BEGIN PGP SIGNED MESSAGE-----

Hello...

realloc() may move the memory being realloated.  To quote from the man page,

       realloc() returns a pointer to the newly allocated memory,
       which is suitably aligned for any kind of variable and may
       be  different from ptr...

It doesn't (and couldn't) mutate the pointer temp_c_buf directly.

Thus, you probably want to re-write your code to do

temp_c_buf = realloc(temp_c_buf, 5000 + 5000);

- --Nicholas Ingolia
ingolia@mit.edu
-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Comment: Processed by Mailcrypt 3.5.3, an Emacs/PGP interface
Charset: noconv

iQCVAwUBN59h+gRHXKx72OUhAQEkNAP/bYZO+zzGI2bDBRuCYabEfaxo8/EAffTN
hliGzKLwhhEetuvrUNv+pam5qBXGb3OLWWAZdRmypEvPXfYP/w3wGlJlGKWxAbGm
WhBJkzwVWEkqKmqADiClP7ucJcMIYkMcLLVcCBnVEsjoPFDumoc2ncEe6beeRDIB
gma/mrLVmZs=
=tyhG
-----END PGP SIGNATURE-----

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
