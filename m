Message-ID: <382076B7.B14665A2@univ-rennes1.fr>
Date: Wed, 03 Nov 1999 17:53:59 +0000
From: Martin Costabel <Martin.Costabel@univ-rennes1.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>,
        Wolfgang Haeuptli <whaeuptli@bluewin.ch>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: compile-error: stdin is not a constant
References: <99110313351500.00438@localhost.localdomain> <19991103103617.A26462@drow.res.cmu.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:
> 
> On Wed, Nov 03, 1999 at 01:25:44PM +0100, Wolfgang Haeuptli wrote:
> >
> > Hello people
> >
> > sorry for the (probably) basic question...
> >
> > Since I installed R5, some programs (that used to compile OK on R4)
> > complain about :
> >
> > initializer element for 'foo' is not constant
> >
> > while compiling constructs like:
> >
> > FILE *foo = stdin;   (or FILE *foo = {(FILE *) stdin};  )
> 
> Because it isn't a constant any more.
> 
> >
> > when I replaced this line with: FILE *foo = STDIN_FILENO;

Maybe this will work (1):

FILE *foo = (FILE *) STDIN_FILENO;

> > ( defined in unistd.h), compilation works, but the resulting program
> > segfaults...
> 
> Which should generate one hell of a warning, since STDIN_FILENO is a
> small number, not a struct FILE *.
> 
> You need to initialize the variable early in main() or something along
> those lines, or you can declare a constructor using __attribute__,
> although I do not remember the syntax (search list archives).

In a similar situation, I learned from Tom Rini that the correct way
would be (2)

static file *file ;
static void file_construct (void) __attribute__((constructor));
static void file_construct (void) { file = stdin; }

This might be in the list archives somewhere. I had a similar problem
with stdout when compiling Scilab. I used Tom's version (2), and it
worked, but I saw that the Scilab people in a later version used the
shorter version (1), and this seems to work, too. 

More precisely, they just added the "|| defined(__GNUC__)" in the
following code:

#if defined(__CYGWIN32__) || defined(__MINGW32__) || defined(__GNUC__)
static FILE *file= (FILE *) 0;
#define FPRINTF(x) ( file != (FILE*) 0) ?  fprintf x  : 0 
#else 
static FILE *file= stdout ;
#define FPRINTF(x) fprintf x  
#endif


--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
