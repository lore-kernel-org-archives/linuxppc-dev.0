Date: Fri, 10 Sep 1999 16:31:33 +0200
From: Maurice DIAMANTINI <diam@pmdiam.ensta.fr>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>, linuxppc-dev@lists.linuxppc.org
Cc: Maurice DIAMANTINI <diam@pmdiam.ensta.fr>
Subject: Re: bug glibc strlen() or tcl8.2
Message-ID: <19990910163126.A19797@pmdiam.ensta.fr>
References: <19990909164200.A17615@pmdiam.ensta.fr> <4.2.0.58.19990909192900.00af6450@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4.2.0.58.19990909192900.00af6450@mail.lauterbach.com>; from Franz Sirl on jeu, sep 09, 1999 at 07:35:41 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


    Vous disiez:
    > 
    > >I'm unable to execute tcl8.2 on linuxppc R5. Although it compile and
    > >and run very simply on intel box, solaris, ... but not on linuxppc
    > > ...
    > >The programm compils OK, but get a core dump at the first execution
    > >of a tcl command (in fact at the "make test")
    > ...
    > >     memcpy ((VOID *) &tmpArgList, (VOID *) &argList, sizeof \
    >                                                (tmpArgList));
    >       ^^^^^^^^
    > This is unportable in combination with va_list. Try:
    >        __va_copy (tmpArgList, argList);
     
    Danke Franz,
    
    But when I modify the code (from the true tcl distrib):
    (I do'nt thes function which aren't part of the tcl distrib.
    
            // string = va_arg(tmpArgList, char *);
            string = __va_arg(tmpArgList, argList);
    
    then "make clean" then "make test" but I get:
    
    cc -c -O -D__NO_STRING_INLINES -D__NO_MATH_INLINES  -fPIC
    -I/home/diam/local/src/tcl/unix/../generic
    -I/home/diam/local/src/tcl/unix -DHAVE_UNISTD_H=1 -DHAVE_LIMITS_H=1
    -DHAVE_GETCWD=1 -DHAVE_OPENDIR=1 -DHAVE_STRSTR=1 -DHAVE_STRTOL=1
    -DHAVE_TMPNAM=1 -DHAVE_WAITPID=1 -DHAVE_UNISTD_H=1
    -DHAVE_SYS_PARAM_H=1 -DUSE_TERMIOS=1 -DHAVE_SYS_TIME_H=1
    -DTIME_WITH_SYS_TIME=1 -DHAVE_TM_ZONE=1 -DHAVE_TM_GMTOFF=1
    -DHAVE_TIMEZONE_VAR=1 -DHAVE_ST_BLKSIZE=1 -DSTDC_HEADERS=1
    -DNEED_MATHERR=1 -DRETSIGTYPE=void -D__CHAR_UNSIGNED__=1
    -DHAVE_SIGNED_CHAR=1 -DHAVE_SYS_IOCTL_H=1
    -DTCL_SHLIB_EXT=\".so\"
    /home/diam/local/src/tcl/unix/../generic/tclResult.c 
    /home/diam/local/src/tcl/unix/../generic/tclResult.c: \
        In function `Tcl_AppendResultVA':
    /home/diam/local/src/tcl/unix/../generic/tclResult.c:488:\
        incompatible types in assignment
    make: *** [tclResult.o] Error 1


    
    Sorry but I'm not very clever in system! I just need to be able
    to compil a standard distrib for tcl...
    Anybody there has tried to compil tcl/tk last version?
    
    (available from http://www.scriptics.com/products/tcltk/8.2.html)
    
    
    When I read this html page :
    
         Supported Platforms 
    
         Tcl/Tk 8.2 is compatible with most releases of the
         following operating systems: 
    
              Windows 95 and 98 
              Windows NT 
              Solaris and SunOS 
              Linux 
              HP-UX 
              SGI 
              IRIX 
              Digital Unix 
              AIX 
              SCO Unix 
              NetBSD, FreeBSD, BSDi 
              Most other Unix-like operating systems 
              Macintosh (68K and Power Mac) 
    
    but not linuppc :-((

-- 
Maurice DIAMANTINI   | Ecole Nationale Superieure de Techniques Avancees
mailto:diam@ensta.fr | 32 Boulevard Victor 75739 PARIS Cedex 15 - France

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
